Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVCaHa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVCaHa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCaH3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:29:20 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6404 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262540AbVCaH0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:26:24 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AMD64 Machine hardlocks when using memset
Date: Thu, 31 Mar 2005 10:25:56 +0300
User-Agent: KMail/1.5.4
References: <3NTHD-8ih-1@gated-at.bofh.it> <424B7ECD.6040905@shaw.ca>
In-Reply-To: <424B7ECD.6040905@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311025.56871.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 07:38, Robert Hancock wrote:
> Philip Lawatsch wrote:
> > Hi,
> > 
> > 
> > I do have a very strange problem:
> > 
> > If I memset a ~1meg buffer some thousand times (in the userspace) it
> > will hardlock my machine.
> 
> I thought that this must be impossible, but I tried it on my machine 
> which is very similar (Asus A8N-SLI, Athlon 64 3500+, 2GB RAM) and to my 
> surprise it breaks on mine too with kernel 2.6.11. I tested using the 
> program below. After about a minute or so of this, the machine either 
> locked hard or rebooted spontaneously. When it locked, there was no oops 
> message, the NMI watchdog was not triggered and there was no response to 
>   SysRq commands. (I tested it with and without the NVIDIA module loaded.)
> 
> This seems pretty terrible, a perfectly legal program running as a 
> normal user is hard-locking the machine. Anyone have any suggestions to 
> debug this? Also, can somebody else on an x86_64 try and duplicate this?
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> 
> int main( int argc, char* argv[] )
> {
> 	char* test = malloc(512*1024*1024);
> 	int i;
> 	for( i=0; i<1000000; i++ )
> 	{
> 		memset( test, 0, 512*1024*1024);
> 	}
> 	free(test);
> 	return 0;
> }

This reminds me on VIA northbridge problem when BIOS enabled
a feature which was experimental and turned out to be buggy.
Was causing oopses ONLY on K7 optimized kernels because
of movntq stores used. They seem to put an awful lot of writes
on the bus.
--
vda

