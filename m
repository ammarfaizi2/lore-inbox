Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269411AbUJFQ0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269411AbUJFQ0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUJFQ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:26:15 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:32091 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269411AbUJFQWs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:22:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, orders@nodivisions.com
Subject: Re: KVM -> jumping mouse... still no solution?
Date: Wed, 6 Oct 2004 11:22:44 -0500
User-Agent: KMail/1.6.2
References: <4163845C.9020900@nodivisions.com> <1097047425.3745.92.camel@scs13> <4163C46A.2050004@nodivisions.com>
In-Reply-To: <4163C46A.2050004@nodivisions.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410061122.45191.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 October 2004 05:09 am, Anthony DiSante wrote:
>  > One quick solution I know of is to restart the gpm daemon,
>  > (/etc/init.d/gpm  restart) that resets the mouse settings.
>  > But this is not the correct way, there should be some way
>  > where the driver automatically detects and resets the mouse.
>  >
> 
> That doesn't work for me either.  Hmm... maybe it's because I'm using a 
> Microsoft mouse... only plays nice with Windows systems?
> 

In 2.6 GPM does not have access to the hardware and therefore cannot reset
it. A temporary fix can be downloaded from here:

	http://bugme.osdl.org/attachment.cgi?id=3244&action=view

It will for only on pre 2.6.9-rc2 kernels. When using kernels 2.6.9-rc3+
there is no automatic re-synchronization [yet] but one can restore a mouse
by issuing the following command:

	echo -n "reconnect" > /sys/bus/serio/devices/serioX/driver

To find out which 'serioX' your mouse connected to just look into their
respective "driver" attributes - the one with "psmouse" is the one you
need.

-- 
Dmitry
