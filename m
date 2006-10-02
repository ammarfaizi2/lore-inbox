Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWJBF0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWJBF0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 01:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWJBF0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 01:26:42 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36846 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932618AbWJBF0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 01:26:41 -0400
Date: Sun, 1 Oct 2006 22:11:49 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Willy Tarreau <w@1wt.eu>
cc: Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>, linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <20061002033531.GA5050@1wt.eu>
Message-ID: <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, Willy Tarreau wrote:

> A lot of improvement can be made in tar to compress better archive with
> large number of small files such as the kernel. You just have to see the
> difference in archive size depending on the base directory name. If you
> come up with something really interesting which does not alter the output
> format nor the compression time, it might get a place in the git-tar-tree
> command. But IMHO, it would me more interesting to further reduce patches
> size than tarballs size, since patches might be downloaded far more often.

I just had what's probably a silly thought.

as an alturnative to useing tar, what about useing a git pack?

create a git archive with no history, just the current files, and then pack it 
with agressive delta options.

since git uses compression on the result anyway it's unlikly to be much worse 
then a tarball, and since it can use deltas across files it may even be better 
(potentially enough better to cover the cost of downloading the git binaries)

this would be especially effective once git adds a 'shallow clone' capability to 
then take the snapshot pack and extend it (either forward or backward as 
requested by the user), but may be worth doing even without this.

thoughts?

David Lang
