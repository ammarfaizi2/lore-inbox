Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264448AbUDZKGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbUDZKGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUDZKGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:06:12 -0400
Received: from kilobug.org ([62.212.118.231]:642 "EHLO drizzt.home")
	by vger.kernel.org with ESMTP id S264471AbUDZKGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:06:04 -0400
To: linux-kernel@vger.kernel.org
Subject: SMP, Soft RAID and abnormal load
Mail-Copies-To: nobody
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Mon, 26 Apr 2004 12:06:03 +0200
Message-ID: <plopm3hdv7qcj8.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

We  are running  a MMO  game  server (made  of several  multi-threaded
porcessus  using CORBA  to communicate)  on a  computer with  two Xeon
processor and a  software RAID level 1 between two  ide discs (hda and
hdc).

The load average is usually around 0.5:
 18:58:11 up 42 days, 1 min,  6 users,  load average: 0.30, 0.41, 0.51

We tried to unzip a zip file containing a lot of small files, and then
the  load average  increased dramatically,  up  to more  than 23.  I'm
wondering how  a single processus  can increase the load  average that
much. 

The kernel is vanilla 2.4.25, with SMP, highmem, and sw raid:
Linux mogii1 2.4.25-raid #1 SMP Tue Feb 24 14:37:33 CET 2004 i686 unknown

The filesystem is ext3fs, mounted with the default "ordered" mode.

The system has plenty of memory available:
             total       used       free     shared    buffers     cached
Mem:       3879840    3750980     128860          0     299948    1709776
-/+ buffers/cache:    1741256    2138584
Swap:      1959848      83964    1875884

I didn't fine-tune the discs with hdparm (this is a production server,
and I  don't want to  take any risk  of data corruption), here  is the
report of hdparm:

 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 14946/255/63, sectors = 240121728, start = 0
 busstate     =  1 (on)

If you have an explication on  why did it happen, I'ld be gratefull. I
hope  this report  may help  you  to "tune"  the kernel.  If you  need
additional informations, don't hesitate to ask.

--
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
