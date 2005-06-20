Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFTLQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFTLQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVFTLQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:16:17 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:60301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261177AbVFTLJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:09:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BSpDZj/jX9dKWwYmt/je47fMMbmPTOUl0MgLRO/D5OTU3s2sLoB+5a8DOdoZuX/FTYXh3LE9Yhi8RC2L4Rcuj1I8t3kefHXQmJT8vtG/PbnHQ2PHEKhJHmGjwv0/RHA/0jCNbKzYdPFUM1x9V/yw9SCKwcqKc+Kxl8Ksvh3PCJ8=
Message-ID: <5c77e707050620040930b4d0cf@mail.gmail.com>
Date: Mon, 20 Jun 2005 13:09:11 +0200
From: Carsten Otte <cotte.de@gmail.com>
Reply-To: Carsten Otte <cotte.de@gmail.com>
To: Mauricio Lin <mauriciolin@gmail.com>
Subject: Re: How to identify cow (copy-on-write) pages during kernel execution?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3f250c7105061922454dfe31ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3f250c7105061922454dfe31ed@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, Mauricio Lin <mauriciolin@gmail.com> wrote:
> I would like to know if there is a way to identify
> struct page that is cow (copy-on-write).
> 
> The way I figured out to identify cow pages is when
> copy-on-write happens. I mean I identify cow pages
> inside the do_wp_page(), the function that handles
> copy-on-write. I have checked do_no_page() as well.
> 
> I have included a field (is_cow) in the struct page to
> identify cow page.
> 
> struct page {
>      ...
>      atomic_t is_cow;
> }
> 
> But I wonder if it is possible to identify cow pages
> before copy-on-write happens. So identify cow pages in
> advance before any process tries to write to a cow
> page.
> 
> I have checked the do_fork(), copy_process() and
> copy_mm() function to try to identify cow pages during
> the process creation, but no success. In copy_mm(),
> just the mm (of current process) is provided to the
> child process, but there are no references to struct
> pages related to mm and its VMAs.
> 
> So when a page struct is considered a cow in the
> kernel and its count variable is updated? Certainly
> the counter page (page->_count) is updated when a page
> is shared because of copy-on-write feature.
> How can I identify cow pages when it becomes cow? Is
> there any feasible way to perform that?
Franky, one cannot predict which pages will get copied on
write since that is related to the behaviour of the process:
if the process writes, then the corresponding page gets copied.
If the vma has the VM_WRITE flag set, and the pte is read-only,
the page is a candidate to become subject to copy on write.
