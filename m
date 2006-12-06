Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937937AbWLGBrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937937AbWLGBrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937941AbWLGBrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:47:53 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:27596 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937937AbWLGBrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:47:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=qrl4OEPLkkiz8BRKUWsWJIPhWvBQJBX4m/mO6SGADCfzB3DoCryTjNwX1x5Tfni3Iqjex6Qyl3RoLecBZ7Yg0sRTNnGp0yzalMwKl72exgd4Da4vQ95+Z2/AwYi+DwaHRMZx0rRcmHLk3+1PeQiyPtvD5PWew1ApypRlopaSpqY=  ;
X-YMail-OSG: ngeHmQMVM1kRl2E2K5jniIAMQYEEpAinlT5OYbzRgmUmrigWyza8Itfo2py1zl.vCrU3Y7kHbnV7CE_OhBE2b7ZeIjyfEiu9rVuq.TzPrhrwqmr94ZIamxCt71NBAQHmlEaZ6xcEK8gZEyA-
From: David Brownell <david-b@pacbell.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port  support.
Date: Wed, 6 Dec 2006 15:47:49 -0800
User-Agent: KMail/1.7.1
Cc: yinghai.lu@amd.com, stuge-linuxbios@cdy.org, stepan@coresystems.de,
       linuxbios@linuxbios.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, gregkh@suse.de, ebiederm@xmission.com
References: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com> <20061206211734.78DCB1E75FF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200612062224.33482.ak@suse.de>
In-Reply-To: <200612062224.33482.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612061547.51524.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 December 2006 1:24 pm, Andi Kleen wrote:
> >   - Host, to which that console connects (through the debug device);
> >     runs usb_debug, much like any other usb-serial device
> 
> My understanding was that the client could run in user 
> space only on top of libusb.

I suppose it could, if you didn't want to use it like a normal
serial consoe.


> > It's analagous to debugging an embedded box using a serial console
> > with a Linux host ... except the target here is a PC, not an ARM
> > (or PPC, MIPS, etc) custom board.
> > 
> > 
> > Once the coexistence issues between the debug port and normal EHCI
> > driver get worked, there's no reason not to keep using that debug
> > port as a system console.  
> 
> One reason is the one I covered in my last mail -- locking of the PCI
> type 1 ports.

That'd be part of coexistence.  The debug port is _designed_ to share
two different drivers like that ... EHCI can see, as it comes up,
whether the debug port is in use, and could then ignore it.  (At least,
unless/until the debug device gets removed.)

- Dave

