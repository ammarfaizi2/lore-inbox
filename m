Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131542AbRC1JWC>; Wed, 28 Mar 2001 04:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131740AbRC1JVx>; Wed, 28 Mar 2001 04:21:53 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59025 "EHLO smtpde02.sap-ag.de") by vger.kernel.org with ESMTP id <S131542AbRC1JVh>; Wed, 28 Mar 2001 04:21:37 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
References: <20010323011331.J7756@redhat.com>
Organisation: SAP LinuxLab
Message-ID: <m3g0fz3qd0.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
Date: 28 Mar 2001 11:18:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, 23 Mar 2001, Stephen C. Tweedie wrote:
> @@ -234,11 +243,11 @@
>  		return -ENOMEM;
>  	}
>  
> -	spin_lock(&info->lock);
> -	shmem_recalc_inode(page->mapping->host);
>  	entry = shmem_swp_entry(info, page->index); 
>	if (IS_ERR(entry)) /* this had been allocted on page allocation */
>  		BUG();
> +	spin_lock(&info->lock);
> +	shmem_recalc_inode(page->mapping->host);
>  	error = -EAGAIN;
>  	if (entry->val) {
>  		__swap_free(swap, 2);

I think this is wrong. The spinlock protects us against
shmem_truncate. shmem_swp_entry cannot sleep in this case since the
entry is allocated in nopage.

Greetings
		Christoph


