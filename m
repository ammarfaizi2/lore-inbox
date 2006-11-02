Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752600AbWKBAJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbWKBAJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbWKBAJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:09:51 -0500
Received: from smtp-out.google.com ([216.239.45.12]:54600 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752589AbWKBAJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:09:49 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=KNHJGk1/41ImrwGnN9PBqZDknbSxOpn/xAq2EPpA8r52GOAToV39zfIhJKthbr87r
	LGoRAuTqnyi343BNISWcg==
Message-ID: <6599ad830611011609t123bba47hf2f3b9a4191d6c12@mail.gmail.com>
Date: Wed, 1 Nov 2006 16:09:42 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] RFC: Memory Controller
Cc: balbir@in.ibm.com, dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061101042341.83cbd77e.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	 <4545FDCD.3080107@in.ibm.com>
	 <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
	 <454782D2.3040208@in.ibm.com>
	 <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
	 <4548472A.50608@in.ibm.com>
	 <6599ad830610312307i549f5a51h3b7a1744a14919f5@mail.gmail.com>
	 <45485046.6080508@in.ibm.com> <20061101042341.83cbd77e.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Paul Jackson <pj@sgi.com> wrote:
>
> Essentially, if my understanding is correct, zone reclaim has tasks
> that are asking for memory first do some work towards keeping enough
> memory free, such as doing some work reclaiming slab memory and pushing
> swap and pushing dirty buffers to disk.

True, it would help with keeping the machine in an alive state.

But when one task is allocating memory, it's still going to be pushing
out pages with random owners, rather than pushing out its own pages
when it hits it memory limit. That can negatively affect the
performance of other tasks, which is what we're trying to prevent.

You can't just say that the biggest user should get penalised. You
might want to use 75% of a machine for an important production server,
and have the remaining 25% available for random batch jobs - they
shouldn't be able to impact the production server.

Paul
