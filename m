Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314504AbSEBO4Q>; Thu, 2 May 2002 10:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSEBO4P>; Thu, 2 May 2002 10:56:15 -0400
Received: from ns.suse.de ([213.95.15.193]:26630 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314504AbSEBO4M>;
	Thu, 2 May 2002 10:56:12 -0400
Date: Thu, 2 May 2002 16:56:11 +0200
From: Dave Jones <davej@suse.de>
To: Andreas Dilger <adilger@turbolabs.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 errors under fsx with 2.5.12-dj1.
Message-ID: <20020502165611.L16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andreas Dilger <adilger@turbolabs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020502143250.GA19533@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:32:50PM +0100, Dave Jones wrote:
 > EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
 > in datazone - block = 2553887680, count = 1

Ugh, I figured out how this was caused, and its somewhat pathological.

What the script should have been doing was two parallel fsx's
one on hdb1 and the other on hdb2. Mounted on /mnt/test-hdb1 and
/mnt/test-hdb2
Due to a screwup in the script I wrote, both were mounting on /mnt/test

net result: chaos as 1 fsx process had another mount another
partition over the top of it.

With the script corrected, it seems to be playing well.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
