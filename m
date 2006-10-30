Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWJ3Rck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWJ3Rck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWJ3Rck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:32:40 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:14062 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030562AbWJ3Rcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:32:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b0fju2/M2LI+AlBdPVQ0nPTWF6EdZo9kJ0hNS9lar+W6hM9VccE9FezfzZpZXsQSp5XXVZzGaC8n1h32HDyiwGw0upDqz2hVWdkMGBTeYtiS8HiTbm9fwWlyDM3zi/n3RHFjz3xqzIrC8TkRFgz1VyGdeXtYsuPVq4pBxAT4dGQ=
Message-ID: <653402b90610300932r3c96445bxb8e5d34f8f768ec4@mail.gmail.com>
Date: Mon, 30 Oct 2006 18:32:37 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <45461890.2000007@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
	 <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
	 <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com>
	 <653402b90610300611ucdc46d9y88f016800b498538@mail.gmail.com>
	 <45461890.2000007@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paulo Marques <pmarques@grupopie.com> wrote:
>
> No, this is not the sequence I thought of at all. I don't remember the
> exact API functions you need to call (I have to read LDD3 again ;), but
> if the hardware supports it, there must be a way. The plan is something
> like:
>
>   - at mmap time you return a pointer to something that is not actually
> mapped, and do nothing else
>
>   - when userspace actually writes to that area, you get a page fault,
> and nopage is called. At this point you map the page, and set the dirty
> state. All other writes from userspace until the timer completes are
> done without faulting.
>
>   - when the timer completes, you unmap the page so that the next access
> will generate a fault again
>
> As I said, I don't remember the exact details, but this should be doable.
>

Yes, I get the idea, you mean to "unmap" the page but don't remove the
vma so a page fault is raised and nopage() op must be called again.
May it decrease performance? (Linux /you must take care of a page
fault calling nopage() each time you write/refresh the LCD, then
actually use it).

      Miguel Ojeda
