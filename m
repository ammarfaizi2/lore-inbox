Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVGCEiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVGCEiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 00:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVGCEiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 00:38:50 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:42639 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261359AbVGCEig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 00:38:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: device_remove_file and disconnect
Date: Sat, 2 Jul 2005 23:38:29 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>, mat@mut38-1-82-67-62-65.fbx.proxad.net,
       matthieu castet <castet.matthieu@free.fr>
References: <42C2D354.6060607@free.fr> <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net> <20050630170406.GA11334@kroah.com>
In-Reply-To: <20050630170406.GA11334@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507022338.30806.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 12:04, Greg KH wrote:
> Hm, in thinking about it, it might make more sense to rework the usb
> core to handle this better.  Possibly add a release() callback to the
> driver when the device is actually being freed.  Wouldn't be that hard
> to do so, and might cut down on some of the common locking errors.
> 

I amafraid this will not help in this particular case - the problem is
with driver-specific memory which is freed way before device disappears.
Consider unloading aiptek module - we need to free aiptek structure when
we unbinding driver but corrsponding USB device will stay there (fully
fucntional with its 'struct device' not going anywhere) until you
physically pull tablet's cord out.

-- 
Dmitry
