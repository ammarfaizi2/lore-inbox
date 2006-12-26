Return-Path: <linux-kernel-owner+w=401wt.eu-S1752418AbWLZHu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbWLZHu6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 02:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbWLZHu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 02:50:58 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:47009 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752418AbWLZHu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 02:50:57 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 02:50:55 EST
Message-ID: <367118962.32541@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 26 Dec 2006 15:42:57 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Sanely size hash tables when using large base pages.
Message-ID: <20061226074257.GA5853@mail.ustc.edu.cn>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20061226061652.GA598@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061226061652.GA598@linux-sh.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Dec 26, 2006 at 03:16:52PM +0900, Paul Mundt wrote:
>  	pidhash_shift = max(4, fls(megabytes * 4));
>  	pidhash_shift = min(12, pidhash_shift);
>  	pidhash_size = 1 << pidhash_shift;
>  
> +	size = pidhash_size * sizeof(struct hlist_head);
> +	if (unlikely(size < PAGE_SIZE)) {
> +		size = PAGE_SIZE;
> +		pidhash_size = size / sizeof(struct hlist_head);
> +		pidhash_shift = 0;

But pidhash_shift is not the order of page ;-)

Regards,
Wu
