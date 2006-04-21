Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWDUOcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWDUOcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWDUOcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:32:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:63420 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932335AbWDUOco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:32:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m3AHHcE4Q0GQ7bTODGPIbfaaO8UuCIm4I7UTDxfT6W1R9abs+T6jCTqjnaISWHPw2cLw1FZmitWNLAJKx57QZra/FbmXrlN/RSHozL/fmu6v5+q2q5fgL69UUzYnsdV30EtIoaaUHjEh6Zp2+Wc+lcimI6NpCUYBVG+USoznYKM=
Message-ID: <a36005b50604210732h69f4408ey99b7895de8dbd902@mail.gmail.com>
Date: Fri, 21 Apr 2006 07:32:43 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Claudio Scordino" <cloud.of.andor@gmail.com>
Subject: Re: [PATCH] Extending getrusage
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       luto@myrealbox.com, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       kernel-janitors@lists.osdl.org, bert.hubert@netherlabs.nl
In-Reply-To: <d0191dad0604210305n7ce4b59aja5d215d92f95e1f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d0191dad0604200821l3fa0ed70ga2faabe79d7718ec@mail.gmail.com>
	 <20060420162140.0a03e227.akpm@osdl.org>
	 <20060421074129.GA31972@outpost.ds9a.nl>
	 <d0191dad0604210305n7ce4b59aja5d215d92f95e1f4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/06, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> Recently, while writing some code at user level, I needed a fast way
> to have such information about another process.

That's not very specific.  And one program isn't really a compelling
reason.  You should specify with some level of detail why you need
that information and why you cannot depend on collaboration of the
process you try to get the information for.


> -               return -EINVAL;
> -       return getrusage(current, who, ru);
> +       struct rusage r;
> +       struct task_struct *tsk = current;
> +       read_lock(&tasklist_lock);

You are introducing scalability problems where there were none before.
 Even if there is some justification revealed in the end IMO the patch
shouldn't be accepted in this form.  You should not slow down the
normal case of operation.  If the current thread is observed the lock
isn't needed.
