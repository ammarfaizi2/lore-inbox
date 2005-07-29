Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVG2UwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVG2UwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVG2UtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:49:23 -0400
Received: from web31704.mail.mud.yahoo.com ([68.142.201.184]:58500 "HELO
	web31704.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262841AbVG2Usp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:48:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C6MjsJC16PxCQ91JNkpgXUK4lIHVrPkjih2lNUoheUC8x34fTxxa/K+rMP6Jd5WqhCJWqO8YpC9krCXjjTPiafHfxrPpA9UobGYOAjnwUFDhm/UrpeLTOJCRs1Y4YG25sje+C4FbmugEHcgBuXW2J4ROKLADthyrDJBgpVDUmMc=  ;
Message-ID: <20050729204845.84212.qmail@web31704.mail.mud.yahoo.com>
Date: Fri, 29 Jul 2005 13:48:44 -0700 (PDT)
From: Doug Reiland <d_reiland@yahoo.com>
Subject: Re: RFC: 64-bit resources and changes to pci, ioremap, ...
To: Kumar Gala <kumar.gala@freescale.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <D72313E7-E2EC-4066-AD2A-02DAFE66B7E6@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

current pentium4 have this problem as well. Shouldn't
need to use the emt64 (x86_64) mode. It takes i/o
bridges and MCH to support it, but the latest Intel
ones do. However, I am pretty sure BIOSes wouldn't
assign the pci/pci-e addresses > 4GIG so most are not
impacted.


--- Kumar Gala <kumar.gala@freescale.com> wrote:

> As I started to update the existing patches to make
> struct resource  
> have 64-bit start and end values I started to see
> all the places that  
> this effects and was hoping to get some discussion
> on what direction  
> we want to take.
> 
> One of the main reasons to make this change is to
> handle processors  
> that have larger physical address space than
> effective.  A number of  
> higher-end embedded processors are starting to
> support larger  
> physical address space while still having a 32-bit
> effective  
> address.  I was wondering if any x86 variants
> support this type of  
> feature?
> 
> The main issue that I'm starting to see is that the
> concept of a  
> physical address from the processors point of view
> needs to be  
> consistent throughout all subsystems of the kernel. 
> Currently the  
> major usage of struct resource is with the PCI
> subsystem and PCI  
> drivers.  The following are some questions that I
> was hoping to get  
> answers to and discussion around:
> 
> * How many 32-bit systems support larger than 32-bit
> physical  
> addresses (I know newer PPCs do)?
> * How many 32-bit systems support a 64-bit PCI
> address space?
> * Should ioremap and variants start taking 64-bit
> physical addresses?
> * Do we make this an arch option and wrap start and
> end in a typedef  
> similar to pte_t and provide accessor macros to
> ensure proper use?
> 
> Andrew has also asked me to post size comparisons of
> drivers/*/*.o  
> building allmodconfig with 32-bit resources and
> 64-bit resources to  
> see what the size growth is.  I'll post logs for
> people to take a  
> look at in a followup email.
> 
> - Kumar
> 



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
