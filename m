Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312459AbSDEKQi>; Fri, 5 Apr 2002 05:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDEKQa>; Fri, 5 Apr 2002 05:16:30 -0500
Received: from ppp15.atlas-iap.es ([194.224.1.15]:30161 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S312459AbSDEKQN>; Fri, 5 Apr 2002 05:16:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Report: 2.4.18 very high latencies (with lowlat. and pre-empt patches)
Date: Fri, 5 Apr 2002 12:16:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16tEL4-0006fr-00@antoli.gallimedina.net> <3CACD3BC.1EB55BCC@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16tQlJ-0007ZV-00@antoli.gallimedina.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/02 00:29, Andrew Morton wrote:
> Ricardo Galli wrote:
> > Hi all (second try),
> >         Linux becomes somehow unusable when I edited sound files and also
> > during NFS copy. I've noticed the same effects also during i/o loads, for
> > example when closing kmail after I deleted some messages.
>
> It would help if you could come up with a simple test case
> which exhibits this problem - some sequence of steps which
> is reproducible by others, and which has repeatable effects.

To test computer A, which has installed Linux 2.4.18 + all low latency 
patches.

1. Put ten (10) to twenty (20) files of 64-80 MB each in computer B. For 
example in /tmp/test.
 
2. Mount in B a disk in A via NFS in, for example, /mnt/A

3. In B, run the following command: 
cp /tmp/test/* /mnt/A

4. Check in A how you mouse freezes.


If you are a Debian Sid user, don't do any dist-upgrade for a couple of days 
and then try it. You will see the same mouse freezes when apt-get is 
installing/configuring packages.


> Is your I/O system performing properly?  Try running
>
> 	hdparm -t /dev/hdaX
>
> where /dev/hdaX refers to your root filesystem.  You
> should get 15-30 megabytes per second.

Yes.

# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.32 seconds = 27.59 MB/sec

> You also report that your PPC-based laptop has processes
> unexpectedly terminating when the machine is under VM
> pressure.  You should check your kernel logs (usually
> /var/log/messages) to see if the process was killed
> due to an out-of-memory condition.  If it's not that,
> and if it's not due to application bugs then the ppc
> kernel may be dropping modified- or dirty-bits in its
> PTEs, which is rather unlikely.


The PPC hasn't any problem at all, it was the NFS server who has killed 
kmail. There were not logged messages at all.

Regards,

-- 
  ricardo
"I just stopped using Windows and now you tell me to use Mirrors?" 
    - said Aunt Tillie, just before downloading 2.5.3 kernel.
