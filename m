Return-Path: <linux-kernel-owner+w=401wt.eu-S1161047AbXALJpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbXALJpg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbXALJpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:45:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:34326 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161047AbXALJpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:45:35 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=r97DlIRCaQhoje1LWP4Alkvap4/dqzuPGiKB4qFwEV76mdP78krIwckI7OUI+tOkubGGkbaKmrjkBNg7MjkzOWm6wLV9nmG+u0+nKrVuqMHO44d4o4DUeLr2VCJ3ZQOsxfUCoqCtDXSR15ikGxozlHLJgYzRx2qenwRykjAFRzY=
Message-ID: <84144f020701120145r13d5d7bbndf652692f729ad9d@mail.gmail.com>
Date: Fri, 12 Jan 2007 11:45:33 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: mprotect abuse in slim
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Mimi Zohar" <zohar@us.ibm.com>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
In-Reply-To: <20070109231449.GA4547@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
	 <1168312045.3180.140.camel@laptopd505.fenrus.org>
	 <20070109094625.GA11918@infradead.org>
	 <20070109231449.GA4547@sergelap.austin.ibm.com>
X-Google-Sender-Auth: 3c2240ee83f69a77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Now, what slim needs isn't "revoke all files for this inode",
> but "revoke this task's write access to this fd".  So two functions
> which could be useful are
>
>         int fd_revoke_write(struct task_struct *tsk, int fd)
>         int fd_revoke_write_iter(struct task_struct *tsk,
>                         (int *)need_revoke(struct task_struct *tsk, int fd))

This gets interesting. We probably need revokefs (which we use
internally as a substitute for revoke inodes) to be stacked on top of
the actual fs so that you can still read from the fd. But most of the
revocation is still the same, we need to watch out for fork(2) and
dup(2) and take down shared mappings.
