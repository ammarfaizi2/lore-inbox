Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUGAWFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUGAWFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUGAWFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:05:08 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:32952 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266319AbUGAWEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:04:51 -0400
Date: Fri, 2 Jul 2004 00:04:48 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mikael.Pettersson@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: perfctr questions
Message-ID: <20040701220448.GA16515@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mikael.Pettersson@csd.uu.se, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael,

I'm trying to test your performance counters stuff, but I can't get it to do
anything remotely useful! Probably just me.

I have a very hard time understanding things like:

 *      perfex -e 0x00039000/0x04000204@0x8000000C some_program
 *
 *      Explanation: Program IQ_CCCR0 with required flags, ESCR select 4
 *      (== CRU_ESCR0), and Enable. Program CRU_ESCR0 with event 2
 *      (instr_retired), NBOGUSNTAG, CPL>0. Map this event to IQ_COUNTER0
 *      (0xC) with fast RDPMC enabled.

I'd love to author a small perfctr howto for people like me who just want to
know if their code is thrashing the cache. 

Do you have a pointer to tools that do this, or, how to calculate these
0x00039000 numbers for perfex? I can't find anything relevant. The best
information I found is in the 'hardmeter' sources.

I tried one very basic thing, perfex -e 0x00410005 ./null which I hoped
would measure unaligned memory accesses, but I can't get this counter raised
from 0. null.c:

int main(int argc, char **argv)
{
        char room[12];
        int i, n;

        for(n=0;n<1000000;++n) {
                i=*((int*)(room+n%4));  
        }
        
        printf("%d\n", i);
}

I'm on a Pentium M, 2.6.7-mm5. Not even sure if an Pentium M will measure
cache misses though.

Thanks

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
