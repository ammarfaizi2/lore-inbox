Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273229AbRIJGt5>; Mon, 10 Sep 2001 02:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273231AbRIJGtt>; Mon, 10 Sep 2001 02:49:49 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:32787 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S273229AbRIJGtj>; Mon, 10 Sep 2001 02:49:39 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Caleb Epstein <cae@bklyn.org>
Date: Mon, 10 Sep 2001 16:49:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15260.25221.456109.19168@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Spurious NFS ESTALE errors w/NFSv3 server, non-v3 client
In-Reply-To: message from Caleb Epstein on Friday September 7
In-Reply-To: <20010906141117.B7579@tela.bklyn.org>
	<15256.45720.351124.767983@notabene.cse.unsw.edu.au>
	<20010907092747.A24283@tela.bklyn.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 7, cae@bklyn.org wrote:
> On Fri, Sep 07, 2001 at 09:42:16PM +1000, Neil Brown wrote:
> 
> > NFSv2 has a limit of 2Gigabytes per file.  Are the files that you are
> > reading close to, or exceeding, this size?
> 
> 	Not that large, no.  They're on the order of tens of
> 	megabytes, maybe 150 MBytes max.
> 
> > However, I wouldn't expect an ESTALE for that reason.  Can you run
> > "tcpdump -s 1024", the the response that contains the error, and
> > send the dozon or so lines around that?
> 
> 	See below for the end of the tcpdump log, which concludes with
> 	the ESTALE.  I've got the entire log saved, which is about 1.4
> 	MB gzipped, available as http://bklyn.org/~cae/tcpdump.log.gz
> 
> 	For this test, server was linux 2.4.9 w/nfsv3 enabled, client
> 	was 2.4.7 with no nfsv3.  Filesystem mounted on the client as:
> 
> tela:/shn on /shn/tela type nfs (rw,rsize=8192,wsize=8192,soft,addr=192.168.1.2,addr=192.168.1.2)
> 
> 	Let me know if I can provide any add'l info that might help.

Well.....

It looks like you are reading through some large file, then you write
to some other file, and when you try to read the file file again, it
isn't there for some reason....

Is there any chance that the file that you are reading from is being
renamed or removed while it is being read?
Can you try exporting with "no_subtree_check" and see if that makes a
difference?
Could you 
    echo 2 > /proc/sys/sunrpc/nfsd_debug 

and get it to fail again, and then show me that last hundred lines or
so of the kernel log.

NeilBrown
