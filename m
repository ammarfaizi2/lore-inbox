Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWJMXWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWJMXWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWJMXWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:22:50 -0400
Received: from web83107.mail.mud.yahoo.com ([216.252.101.36]:42933 "HELO
	web83107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750992AbWJMXWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:22:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FS1prdhH8uRiH3pLCc/TEqFBgeTxO/9uOk+01iMbRzXt2+bBImfNq7HiP4h6FblTZuVStbY6t8hDCsErxPtprOAJs73PC5pHzRN2d5Zpgn6wuvX4lQ8AHSoT3zcjvizPZi6D+a8dSA4lBXRbKnawNGXTG37IpzcRc9GApZmIaIA=  ;
Message-ID: <20061013232248.83292.qmail@web83107.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 16:22:48 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine reboot
To: Auke Kok <auke-jan.h.kok@intel.com>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: ryan@tau.solarneutrino.net, linux-kernel@vger.kernel.org,
       magnus.damm@gmail.com, pavel@suse.cz
In-Reply-To: <452FA451.6090702@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Auke Kok <auke-jan.h.kok@intel.com> wrote:

> > 
> > For i965 chipsets, the BIOS is *a lot* buggy :(
> 
> that's depressing, can you send me the output of `dmidecode` of the latest BIOS? Perhaps 
> I can reproduce it myself with that version.
> 
Hi, Auke

 It looks like the reason for reboot failure is unability of BIOS to reboot if network pci device
is in D3 state. Once I've added 
 	pci_set_power_state(pdev, PCI_D0);
as a last line to e1000_shutdown() method, board started rebooting again.
Moreover, here is what I found in release notes to the latest BIOS (from October 5, 2006):
"Fixed an issue where system not able to shutdown to S5 if the LAN is set to D3 mode."
This may have affected reboot with LAN in D3 negatively.
  I guess you are in the best position of all of us to bring the issue to Intel BIOS team. 

Aleks.
   

