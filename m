Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUI3Ick@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUI3Ick (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUI3Ick
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:32:40 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:50873 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S269063AbUI3Ici
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:32:38 -0400
Date: Thu, 30 Sep 2004 10:32:36 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, dsaxena@plexity.net,
       linux-kernel@vger.kernel.org, herbertb@cs.vu.nl
Subject: Re: strange NFS problems (ARM client, x86 server)
Message-ID: <20040930083236.GA32262@xi.wantstofly.org>
References: <20040929082307.GA19666@xi.wantstofly.org> <20040929203347.GD21770@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929203347.GD21770@thundrix.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 10:33:47PM +0200, Tonnerre wrote:

> Salut,

Hi,


> > chdir("")                               = -1 ENOENT (No such file or directory)
> 
> Interestingly,  rpm requested an  empty chdir.  This narrows  down the
> problem.

I don't think it does, as the second invocation of RPM (after cd 'pwd')
also does this, but works fine.


> The following miniapp should be able to reproduce the problem:
> 
> cat << EOT > blah.c
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> 
> int main(void) {
> 	if (chdir("")) {
> 		perror("chdir");
> 		exit(1);
> 	}
> 	exit(0);
> }
> EOT

'current directory' is per-process state.  You'll end up changing the
current directory in the child process, but not the parent.


--L
