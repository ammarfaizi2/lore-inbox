Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUAOTBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAOTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:01:35 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:31373
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261807AbUAOTB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:01:29 -0500
Subject: Slowwwwwwwwwwww NFS read performance....
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linuxram@us.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1074134135.1522.52.camel@nidelv.trondhjem.org>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
	 <1074025508.1987.10.camel@lumiere>
	 <1074026758.4524.65.camel@nidelv.trondhjem.org>
	 <bu4pd6$anf$1@news.cistron.nl>
	 <1074134135.1522.52.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074193256.2148.55.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 14:00:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 14/01/2004 klokka 21:35, skreiv Trond Myklebust:

> Err.. no...
> 
> I didn't have a 2.6.1-mm3 machine ready to go in our GigE testbed (I'm
> busy compiling one up right now). However I did run a quick test on
> 2.6.0-test11. Iozone rather than bonnie, but the results should be
> comparable:

Hah.... They turned out not to be...

The changeset with key 

akpm@osdl.org[torvalds]|ChangeSet|20031230234945|63435

# ChangeSet
#   2003/12/30 15:49:45-08:00 akpm@osdl.org
#   [PATCH] readahead: multiple performance fixes
#
#   From: Ram Pai <linuxram@us.ibm.com>


Has a devastating effect on NFS readahead. Using iozone in sequential
read mode, I get a 90% drop in performance on my GigE against a fast
NetApp filer. See the following test results.

Cheers,
  Trond

------------------------
        Iozone: Performance Test of File I/O
                Version $Revision: 3.169 $
                Compiled for 32 bit mode.
                Build: linux
                                                                                
        Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
                     Al Slater, Scott Rhine, Mike Wisner, Ken Goss
                     Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
                     Randy Dunlap, Mark Montague, Dan Million,
                     Jean-Marc Zucconi, Jeff Blomberg.
                                                                                
        Run began: Thu Jan 15 13:38:42 2004
                                                                                
        Include close in write timing
        File size set to 2097152 KB
        Record Size 128 KB
        Command line used: /plymouth/trondmy/public/programs/fs/iozone -c -t1 -s 2048m -r 128k -i0 -i1
        Output is in Kbytes/sec
        Time Resolution = 0.000001 seconds.
        Processor cache size set to 1024 Kbytes.
        Processor cache line size set to 32 bytes.
        File stride size set to 17 * record size.
        Throughput test with 1 process
        Each process writes a 2097152 Kbyte file in 128 Kbyte records
                                                                                
        Children see throughput for  1 initial writers  =  107477.06 KB/sec
        Parent sees throughput for  1 initial writers   =  107469.93 KB/sec
        Min throughput per process                      =  107477.06 KB/sec
        Max throughput per process                      =  107477.06 KB/sec
        Avg throughput per process                      =  107477.06 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for  1 rewriters        =  108333.84 KB/sec
        Parent sees throughput for  1 rewriters         =  108326.78 KB/sec
        Min throughput per process                      =  108333.84 KB/sec
        Max throughput per process                      =  108333.84 KB/sec
        Avg throughput per process                      =  108333.84 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for  1 readers          =   39179.22 KB/sec
        Parent sees throughput for  1 readers           =   39178.28 KB/sec
        Min throughput per process                      =   39179.22 KB/sec
        Max throughput per process                      =   39179.22 KB/sec
        Avg throughput per process                      =   39179.22 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for 1 re-readers        =   14926.65 KB/sec
        Parent sees throughput for 1 re-readers         =   14926.62 KB/sec
        Min throughput per process                      =   14926.65 KB/sec
        Max throughput per process                      =   14926.65 KB/sec
        Avg throughput per process                      =   14926.65 KB/sec
        Min xfer                                        = 2097152.00 KB
 
-------------------------------------------------------------------------------

If I remove just that one patch, then read performance is back to what
is expected:

        Iozone: Performance Test of File I/O
                Version $Revision: 3.169 $
                Compiled for 32 bit mode.
                Build: linux
                                                                                
        Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
                     Al Slater, Scott Rhine, Mike Wisner, Ken Goss
                     Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
                     Randy Dunlap, Mark Montague, Dan Million,
                     Jean-Marc Zucconi, Jeff Blomberg.
                                                                                
        Run began: Thu Jan 15 13:57:51 2004
                                                                                
        Include close in write timing
        File size set to 2097152 KB
        Record Size 128 KB
        Command line used: /plymouth/trondmy/public/programs/fs/iozone -c -t1 -s 2048m -r 128k -i0 -i1
        Output is in Kbytes/sec
        Time Resolution = 0.000001 seconds.
        Processor cache size set to 1024 Kbytes.
        Processor cache line size set to 32 bytes.
        File stride size set to 17 * record size.
        Throughput test with 1 process
        Each process writes a 2097152 Kbyte file in 128 Kbyte records
                                                                                
        Children see throughput for  1 initial writers  =  109917.64 KB/sec
        Parent sees throughput for  1 initial writers   =  109915.87 KB/sec
        Min throughput per process                      =  109917.64 KB/sec
        Max throughput per process                      =  109917.64 KB/sec
        Avg throughput per process                      =  109917.64 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for  1 rewriters        =  110838.23 KB/sec
        Parent sees throughput for  1 rewriters         =  110830.83 KB/sec
        Min throughput per process                      =  110838.23 KB/sec
        Max throughput per process                      =  110838.23 KB/sec
        Avg throughput per process                      =  110838.23 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for  1 readers          =  146490.67 KB/sec
        Parent sees throughput for  1 readers           =  146487.63 KB/sec
        Min throughput per process                      =  146490.67 KB/sec
        Max throughput per process                      =  146490.67 KB/sec
        Avg throughput per process                      =  146490.67 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for 1 re-readers        =  163164.72 KB/sec
        Parent sees throughput for 1 re-readers         =  163148.56 KB/sec
        Min throughput per process                      =  163164.72 KB/sec
        Max throughput per process                      =  163164.72 KB/sec
        Avg throughput per process                      =  163164.72 KB/sec
        Min xfer                                        = 2097152.00 KB
 
 
Cheers,
  Trond
