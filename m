Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRBSDkm>; Sun, 18 Feb 2001 22:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbRBSDkd>; Sun, 18 Feb 2001 22:40:33 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:9480 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129991AbRBSDkT>; Sun, 18 Feb 2001 22:40:19 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: dek_ml@konerding.com
Date: Mon, 19 Feb 2001 14:40:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14992.38288.497367.324493@notabene.cse.unsw.edu.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4 
In-Reply-To: message from dek_ml@konerding.com on Sunday February 18
In-Reply-To: <14992.27362.114723.93990@notabene.cse.unsw.edu.au>
	<200102190256.f1J2uIs23040@konerding.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 18, dek_ml@konerding.com wrote:
> 
> OK, I grabbed these patches and applied them against 2.4.2-pre4 and
> recompiled, rebooted.  I am now able to use reiserfs with NFS,
> basic operations appear to work as expected but I haven't done large amounts
> of file IO or lots of concurrent requests.  
> 
> What is the plan with regards to these patches, or ones like it, making it into
> the distribution? 

The changes to knfsd are fairly big and mean that every filesystem
type that is to be exported needs to explicitly provide support for
knfsd.

I have almost completed doing this for
  ext2fs reiserfs isofs ufs efs

which were the only ones that were mentioned when I asked "what
filesystem types do you want to export" on the nfs list.
The isofs stuff needs more work to be *right*, but it should be at
least as good as the current code provides. (i.e. it works as long as
things don't get flushed out of the dentry cache).

The reiserfs bit needs work to get generation number checking done.
This is being worked on by  Danilov Nikita.

I hope to put out a patch set for testing in a day or so and possibly
suggest it to Alan for his -ac series.  I don't see it going into
2.4.2, but 2.4.3 might be possible if Linus agrees.

NeilBrown
