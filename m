Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbULQSFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbULQSFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULQSFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:05:34 -0500
Received: from mproxy.gmail.com ([216.239.56.245]:22903 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262100AbULQSFX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:05:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AQYUYlSTUnVjftnrumrs3Ev3ibNcYUf53cDtLvzbXlvLj/lk2FJDENKqj0JvXjsqe/GJnK4bnmDeqTF12u/xL19FhcR8BH1s4VbHm607He3pwTkUisX65wONas7mqGIVytDB89SLMjPP1vuCSFnLMvxTQI/992HsImfblwIIBY4=
Message-ID: <8924577504121710054331bb54@mail.gmail.com>
Date: Fri, 17 Dec 2004 12:05:21 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?" (Plain)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41C31421.7090102@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <89245775041217090726eb2751@mail.gmail.com>
	 <41C31421.7090102@mtg-marinetechnik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that the driver does not re-enable interrupts or the
transmit and receive engines after it resets the adapter because of
the PCI bus error.

So, I would like to provide you with a patch which will log the state
of these registers after the adapter reset and during the transmit
timeout events to dmesg.  If you do not have the kernel source
available, I can try and compile the module for you (it will just take
a bit longer, as I will have to find the SuSE 9.2 source).

Thanks,
Jon


On Fri, 17 Dec 2004 18:15:13 +0100, Richard Ems
<richard.ems@mtg-marinetechnik.de> wrote:
> Jon Mason wrote:
> > It seems to me the cause of the tx timeouts is the "HostError", which
> > is a PCI bus error.  This most likely caused the adapter to hang and
> > then the transmits started timing out.
> >
> > As far as I can tell, the dl2k driver code is common between 2.4 and
> > 2.6.  So, some other change in the kernel is causing the driver to
> > behave differently and expose this problem.
> >
> > I am not the maintainer, but I can try to assist you. However, it will
> > require running debug drivers (as I am not able to find any
> > documentation on this adapter).  If you are not willing or able to do
> > this, then I would suggest going back to the 2.4 kernel.
> 
> Ok, yes, I'm willing to try your debug drivers. We'll see if I'm also
> able ;-)
> 
> What shall I do?
> 
> Thanks ,Richard
> 
> --
> Richard Ems
> 
> MTG Marinetechnik GmbH
> Wandsbeker Königstr. 62
> 22041 Hamburg
> Telefon: +49 40 65803 312
> TeleFax: +49 40 65803 392
> mail: richard.ems@mtg-marinetechnik.de
> 
>
