Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161329AbWHJPQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbWHJPQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHJPQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:16:00 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:6538 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751440AbWHJPP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:15:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/lWS+Qcv0uZ/l3HPXPrrnyRa+mOblOAYGQtn7mj7jb/tuK3RdlUsQ/5eSO9w/GDHD1+xr55q5cif7epFx1qxuEBmF1paQjljbXbB/99dtT4MS2b+RzF7Hw5VuryBzFrtzmrffoaAH3fO8dGaz3OZPh/n43EpbSdCW83NY5juuE=
Message-ID: <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
Date: Thu, 10 Aug 2006 11:15:57 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <17626.52269.828274.831029@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am considering another possibility: suppose client C1 does lookup()
on file X and gets a file handle, which include inode number,
generation number and parent's inode number. Before C1 issues
getattr(), C2 move the parent directory to a different place, which
will not change the parent's inode number, neither the file X's inode,
i_generation. So when C1 issues a getattr() request with this file
handle, the server seems to have no way to detect that file X is not
existent at the original path. Instead, the server will returns the
moved X's attributes, which are correct, but semantically wrong. Is
there any way that server deal with this problem?

Thanks a lot!
-x

On 8/10/06, Neil Brown <neilb@suse.de> wrote:
> On Thursday August 10, uszhaoxin@gmail.com wrote:
> > Many thanks for your kind help!
> >
> > Your answer is what I expected. But what frustrated me is that I
> > cannot find the code that verifies the generation number in NFS V3
> > codes. Do you know where it check the generation number?
>
> NFSD doesn't.  The individual filesystem does.  You need to look in
> the filesystem code.
>
> Some filesystems use common code from fs/exportfs/expfs.c
> See "export_iget".
>
> NeilBrown.
>
