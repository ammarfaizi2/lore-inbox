Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291846AbSBAQuz>; Fri, 1 Feb 2002 11:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291848AbSBAQup>; Fri, 1 Feb 2002 11:50:45 -0500
Received: from ns.suse.de ([213.95.15.193]:29202 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291846AbSBAQue>;
	Fri, 1 Feb 2002 11:50:34 -0500
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
In-Reply-To: <20020201163818.A32551@caldera.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Feb 2002 17:50:33 +0100
In-Reply-To: Christoph Hellwig's message of "1 Feb 2002 16:43:43 +0100"
Message-ID: <p73d6zpno2u.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@caldera.de> writes:

	
>     void *data;
> 
> 	Opaque data for the thread's use.

That requires to dynamically allocate and initialize kthread if you
can have potentially multiple threads (= too much to write) 

I think it would be better to pass data as a separate argument.
You can put the kthread and the data into a private structure on
the stack, pass the address of it to kernel_thread and wait until the 
thread has read it using a completion. 

That would make a nicer API. 

-Andi
