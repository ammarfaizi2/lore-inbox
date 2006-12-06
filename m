Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937767AbWLFXFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937767AbWLFXFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937768AbWLFXFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:05:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:39366 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937767AbWLFXFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:05:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PwVlB7C40fncmFBee0y1cKzPjoOAXKvLUcUxPMn6OPTSENJSNgqGKBEfLyfPgQGLaRr6cTEnkV4unBf/loXhrOf9RRn+FVRp6cx6F9TZwRt9CNCkbaWw6TX4n7u1t+XhUaQfqrSMjAfvUAuvAOOXwX2uo4E4akrz8PSMzRjUL4g=
Message-ID: <a10e25a30612061505i4e9ea428g473d5bead437845a@mail.gmail.com>
Date: Wed, 6 Dec 2006 15:05:22 -0800
From: "Kunal Trivedi" <ktrivedilkml@gmail.com>
To: linuxkernel <linux-kernel@vger.kernel.org>
Subject: dentry cache grows to really large number on 64bit machine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am running 2.6.18 kernel on 64 bit AMD machine. (procinfo attached
at the end of the mail). One of the things I have noticed that
dentry_cache grows really fast under certain code path.
So, far I have not seen any problems, but I would like to get some
more input on this subject. Is it okay for dentry_cache to grow that
much ?

I've run following program for an ~1.00 hour. And my slabinfo shows following.

# cat /proc/slabinfo | grep dentry
dentry_cache      5228333 5228333    224   17    1 : tunables  120
60    8 : slabdata 307549 307549      0


# cat /proc/meminfo
MemTotal:      8173080 kB
MemFree:       6787852 kB
Buffers:         42048 kB
Cached:          72616 kB
SwapCached:          0 kB
Active:          88608 kB
Inactive:        29796 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      8173080 kB
LowFree:       6787852 kB
SwapTotal:     2096472 kB
SwapFree:      2096472 kB
Dirty:              48 kB
Writeback:           0 kB
AnonPages:        3716 kB
Mapped:           3336 kB
Slab:          1251292 kB
PageTables:        192 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:  10269552 kB
Committed_AS:    11500 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      1272 kB
VmallocChunk: 34359737015 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     2048 kB


int
main()
{
    int fd;
    char fname[] = "/tmp/proc-output-XXXXXX";

    fd = mkstemp(fname);
    close(fd);
    unlink(fname);
    return 0;
}

Please advice,

Thanks
-Kunal
