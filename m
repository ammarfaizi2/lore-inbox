Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFOH6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFOH6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 03:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVFOH6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 03:58:17 -0400
Received: from mout2.freenet.de ([194.97.50.155]:46511 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261232AbVFOH6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 03:58:08 -0400
Subject: FIGETBSZ and FIBMAP for directorys
From: Sebastian =?ISO-8859-1?Q?Cla=DFen?= 
	<Sebastian.Classen@freenet-ag.de>
Reply-To: Sebastian.Classen@freenet-ag.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 15 Jun 2005 09:58:07 +0200
Message-Id: <1118822287.28239.10.camel@basti79.freenet-ag.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list...

I'm using this little program to find out which blocks are use by a
particular file:
int main(int argc, char **argv) {
        int             fd,
                        i,
                        block,
                        blocksize,
                        bcount;
        struct stat     st;

        assert(argv[1] != NULL);
        assert(fd=open(argv[1], O_RDONLY));
        assert(ioctl(fd, FIGETBSZ, &blocksize) == 0);
        assert(!fstat(fd, &st));
        bcount = (st.st_size + blocksize - 1) / blocksize;
        printf("File: %s Size: %d Blocks: %d Blocksize: %d\n", 
                argv[1], st.st_size, bcount, blocksize);
        for(i=0;i < bcount;i++) {
                block=i;
                if (ioctl(fd, FIBMAP, &block)) {
                        printf("FIBMAP ioctl failed - errno: %s\n",
                                        strerror(errno));
                }
                printf("%3d %10d\n", i, block);
        }
        close(fd);
}


This works fine for regular files, but not for directorys. Both ioctl's,
FIGETBSZ and FIBMAP, are implemented for regular files only. 

Is there a patch to make this FIGETBSZ and FIBMAP work on directorys
too?
Or alternativly, is there a way to find out which blocks are used by a
directory?

Thanks for answers in advance
  Sebastian.


