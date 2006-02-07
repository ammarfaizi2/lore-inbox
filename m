Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWBGCD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWBGCD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWBGCD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:03:26 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:54848 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S964936AbWBGCDZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:03:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Date: Mon, 6 Feb 2006 18:03:21 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3B01A40@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Thread-Index: AcYgUoTWrbiDXjvPRgirITVTpstZ+wLN1idg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "David Brownell" <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>
Cc: "Andrew Morton" <akpm@osdl.org>, "Carlo E. Prelz" <fluido@fluido.as>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2006 02:03:24.0898 (UTC) FILETIME=[ADDBC420:01C62B8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of David Brownell
>Sent: Monday, January 23, 2006 11:01 AM
>To: linux-usb-devel@lists.sourceforge.net
>Cc: Andrew Morton; Carlo E. Prelz; linux-kernel@vger.kernel.org
>Subject: Re: [linux-usb-devel] Re: ATI RS480-based 
>motherboard: stuck while booting with kernel >= 2.6.15 rc1
>
>
>> OK, so it sounds like quirk_usb_disable_ehci() caused your 
>machine to hang
>> with the old BIOS.  That's fairly bad behaviour from the kernel, even
>> though the BIOS presumably had some problems.
>
>I think what happened is the "always run quirks" code got turned into
>the default too early, before the EHCI "quirk" version of the handoff
>code got checked against what most systems have been using for the past
>several years.
>
>I noticed at least one suspicous thing:  it enables an SMI IRQ.

  As far as I recall, some BIOSes can be stuck at handoff forever
waiting for SMI if this is not enabled. No doubt BIOS bug, and seems
like work around brakes some other systems, grrr...

>Even in cases when the boot firmware says it's not using EHCI ...
  That's what I do not understand. SOOE is enabled only if BIOS ownes
EHCI - check for ECHI_USBLEGSUP_BIOS in previous 'if' statement. Am I
missing something ?

Thanks,
Aleks.

>easy to imagine that causing hangage.
>
>
>Maybe this time it'd help to tell your BIOS "yes, DO use USB".
>Or, the attached patch might help.  Please try both experiments.
>
>- Dave
>
>
>
