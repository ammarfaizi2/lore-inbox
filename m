Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWAYOoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWAYOoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAYOoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:44:38 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:2585 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbWAYOoh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:44:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iQ3JJw55qUXzkNI5sw23hJLiX1gvWTTZ/Hx2rvVBzJ/pDQ1rhFN4h5qPaGG6H1zTbUBfAElkJBn9BRhdCZDUNqfQi/F4ACI0YRElj08Ir73zWZNvf8ysIiNELtKvvd8clQsxHsd/jq+uXRZuMZhlv8T/QTdVdA4tjvjtCUrxK/s=
Message-ID: <84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>
Date: Wed, 25 Jan 2006 16:44:36 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.16-rc1-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D785E1.4020708@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <43D785E1.4020708@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 1/25/06, Andy Whitcroft <apw@shadowen.org> wrote:
> It seems that something is causing panic's on some of our test beds.  At
> first sight it appears to be something slab related (alloc_slabmgmt).  I
> had a quick look at what had been added in -mm3 (as -mm2 is ok) but the
> only things that jumped out really didn't want to be backed out.
>
> Any suggestions as to what I should try?

Does reverting the following patch make the panic go away?

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/broken-out/slab-cache_estimate-cleanup.patch

If not, you can safely revert the following patches one by one in reverse order:

slab-distinguish-between-object-and-buffer-size.patch
slab-minor-cleanup-to-kmem_cache_alloc_node.patch
slab-have-index_of-bug-at-compile-time.patch
slab-cache_estimate-cleanup.patch
slab-extract-slab_destroy_objs.patch
slab-extract-slab_putget_obj.patch
slab-reduce-inlining.patch
slab-extract-virt_to_cacheslab.patch
slab-rename-ac_data-to-cpu_cache_get.patch
slab-replace-kmem_cache_t-with-struct-kmem_cache.patch
slab-fix-kzalloc-and-kstrdup-caller-report-for-config_debug_slab.patch
mm-slab-add-kernel-doc-for-one-function.patch
slab-fix-sparse-warning.patch

                         Pekka
