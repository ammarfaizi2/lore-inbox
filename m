Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937650AbWLFVRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937650AbWLFVRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937652AbWLFVRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:17:38 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:35666 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937650AbWLFVRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:17:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=245mNVH0aJy1RJQZ+1h8F1V+X6IX1j3q+C5CadlcDtwR8G0SNslUXWsYiOgklYVUGFo7vKJHgHcnK1dszZjU8k0C8yblni8jv8YFPX1zD3rm207lyMf4Nr+l/w2MSENmRkjGAE5AjhH5cBmLws3Ktgz8ItSqqLbKrAjV8lMG0Mk=  ;
X-YMail-OSG: AqnhiT4VM1lGKwkFUhbMg3Wr.Hn671mPHo4WP4hoGgGqNdyqGLl3XiEu6tzR7c1y6rHCYknp9.C_Ix6O5lxq0yq2idm9uJJ7acLshZEmfm8q.v2894ZY.1tq8ja37kmz6.dj9vYqkmmGSuY-
Date: Wed, 06 Dec 2006 13:17:34 -0800
From: David Brownell <david-b@pacbell.net>
To: yinghai.lu@amd.com, ak@suse.de
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port 
 support.
Cc: stuge-linuxbios@cdy.org, stepan@coresystems.de, linuxbios@linuxbios.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de, ebiederm@xmission.com
References: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com>
 <200612062158.39250.ak@suse.de>
In-Reply-To: <200612062158.39250.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061206211734.78DCB1E75FF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > or usb_debug that Greg just added 
>
> Ah I didn't notice that. If there is a usb_debug that works later
> then yes it would need to be disabled.

I detect confusion here ... remember that there are potentially two
distinct Linux systems involved here:

  - Target, with some kind of console hooked up to the debug device;
    runs this _new_ "early debug port" code.

  - Host, to which that console connects (through the debug device);
    runs usb_debug, much like any other usb-serial device

It's analagous to debugging an embedded box using a serial console
with a Linux host ... except the target here is a PC, not an ARM
(or PPC, MIPS, etc) custom board.


Once the coexistence issues between the debug port and normal EHCI
driver get worked, there's no reason not to keep using that debug
port as a system console.  Heck, being able to do that might be a
huge win with some of the nasty suspend/resume problems we've got.

- Dave

