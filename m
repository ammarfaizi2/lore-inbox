Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268112AbUHFKKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268112AbUHFKKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268118AbUHFKKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:10:23 -0400
Received: from main.gmane.org ([80.91.224.249]:24753 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268112AbUHFKKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:10:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: EXT intent logging
Date: Fri, 06 Aug 2004 19:57:54 +1000
Message-ID: <87zn58lhb1.fsf@enki.rimspace.net>
References: <S268081AbUHFEzL/20040806045511Z+197@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203-217-29-45.perm.iinet.net.au
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEUnIyatfG0aGBsMChBG
 NThoSkb52Lk0unwsAAACeElEQVR42l2UMZPbIBCF9zDqw4xRzYDTO5LTY92SWsyx11NE//8n5AGK
 LxMVtkcfb/fxWEzr61nWfx8aX57CnVUI/wPNRQH41Ycv4PGZJEZ/25pSjbKeXLwsTkrimArWeNdb
 eU+aNzVJkkJlJ78uzvu/IGqRImXnElHHkQ/BAzjUEBErPhXyS3CMtwvAQuhgjOzJGFOCd5p8e/Dp
 JOWS7HwchynK3QhtwgrwvXAqn+39Ua9818qBLAConbi/P6ot5Iiol6JiSZ51ACMNIAIodLJ0zccJ
 bKQGoKD4vN7EvMBO5AbgXCaxx6sUnXZTEZuSGc0RAXoMhUi6NlDBbJEdqbrY7L5ABogqOkfq3hXY
 tEx1NnIcNttyQ4qqKcqe0ANdcwPGbHB72tW2vFVT52YKoVBs8a6kI0t5M6fbw1iKEIRATCmlt3lk
 aGaTS3F9HxwLjI39/c4ZgHyLl5gZvnopA1fW7IgKW8SZ48jN6GEyfO3DFmmNI5/PEA1qkRs9HLOk
 ExgLLbkRoiMt3EtVjIQY63T8As98KrL5hp2No/Vaokg9JeitmakpFKF7qafEREwGx35cjlOSsXWD
 RLg/DeAnDNcTRKzvxLfBivx5wBiyv7YO1Ir5VivSPNzmK1JVRHqMBKKHp6NKls31Imi+NAnxOTzb
 eiflOhi3IfWt292HRfWVDQS/3g09MQ60qXVRWIfUGwjhh2h+ME9aPeIYxBYJrnbe9g0zqLegY5/D
 BqBc6nvC9b+Jv3B0uPodtEr2AvuF9zvxhhDfcW+bImR7wXlNMdBPxkWjfe0K/6hWuYlZT2ihMNUp
 4r9kWcKvanWOj+2DAkeFE0xpD38AQw3cf9DOFKYAAAAASUVORK5CYII=
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
Cancel-Lock: sha1:MiN4+VGliNjClGgUG85rZd6P3so=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2004, Buddy Lumpkin wrote:
> I recently moved from a Sun/Solaris environment to a mostly linux environment
>
> A large NFS server went down recently and as it rebooted, fsck ran for
> a while before the data volumes could be mounted. I noticed the
> filesystem was ext3 and asked, is journaling disabled? Why on earth is
> fsck running at all? The admin assured me this is quite normal for
> ext3 and after a few minutes, the system was brought back online.

What is normal is that ext3 will perform an *occasional* fsck - by
default, once a month or every thirty-odd mounts - to catch any
corruption that has been missed by the journaling.

Also, the fsck will replay the journal outside the kernel if possible,
so you may have witnessed the journal replay.

This is done because it allows multiple filesystems to replay the
journal in parallel rather than sequentially as doing it in-kernel would
require.

Regards,
        Daniel


-- 
If you ever reach total enlightenment while you're drinking a beer,
I bet it makes beer shoot out your nose.
        -- Jack Handy

