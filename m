Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283708AbRLISIw>; Sun, 9 Dec 2001 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283717AbRLISIm>; Sun, 9 Dec 2001 13:08:42 -0500
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:8712 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S283708AbRLISIX>; Sun, 9 Dec 2001 13:08:23 -0500
Date: Sun, 9 Dec 2001 19:05:57 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat and disk_io
Message-ID: <20011209190557.F1271@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <003801c180cd$51055700$0801a8c0@Stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <003801c180cd$51055700$0801a8c0@Stev.org>; from mistral@stev.org on Sun, Dec 09, 2001 at 04:19:45PM -0000
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 04:19:45PM -0000, James Stevenson wrote:
> from /proc/stat i get the following
> 
> disk_io: (3,0):(167751,94458,3917566,73293,2420568)
> (3,1):(59314,45093,2747844,14221,114376)
> (11,0):(9855,9855,1258392,0,0)
> 
> except the device 11,0 is a cd-reader
> and there is a device 11,1 which has been used
> is there any reson why the stats dont show up ?
> after all it is another disk.

Both cdroms are accounted, but only into the same slot (11,0). In function
disk_index() at the end of include/linux/genhd.h, you can add a line
	case SCSI_CDROM_MAJOR:
above the line containing SCSI_DISK0_MAJOR, and things will work as expected.
Several more complete patches have been floating around for a while.

Regards,

Daniel.

