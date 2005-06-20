Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFTFps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFTFps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 01:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVFTFps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 01:45:48 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:61616 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261450AbVFTFpk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 01:45:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M3rnFW0itYFGZl4cAeD/AtlXCRr/mZhf7SslrfQ1Gz9NUbAGgB7qmk2jbBvfJreDV613X/yQGYeFLxqwWQHDoij8quf5wexvPzAQYgnqYZ9rpSELJ4z3TM3GzCgnK0amyEa9fxtZkLtC+Q9NFNrC30Y0sRGC0JG+8XJy9hjgmbs=
Message-ID: <3f250c7105061922454dfe31ed@mail.gmail.com>
Date: Mon, 20 Jun 2005 01:45:04 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to identify cow (copy-on-write) pages during kernel execution?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would like to know if there is a way to identify
struct page that is cow (copy-on-write).

The way I figured out to identify cow pages is when
copy-on-write happens. I mean I identify cow pages
inside the do_wp_page(), the function that handles
copy-on-write. I have checked do_no_page() as well.

I have included a field (is_cow) in the struct page to
identify cow page.

struct page {
     ...
     atomic_t is_cow;
}

But I wonder if it is possible to identify cow pages
before copy-on-write happens. So identify cow pages in
advance before any process tries to write to a cow
page.

I have checked the do_fork(), copy_process() and
copy_mm() function to try to identify cow pages during
the process creation, but no success. In copy_mm(),
just the mm (of current process) is provided to the
child process, but there are no references to struct
pages related to mm and its VMAs.

So when a page struct is considered a cow in the
kernel and its count variable is updated? Certainly
the counter page (page->_count) is updated when a page
is shared because of copy-on-write feature. 
How can I identify cow pages when it becomes cow? Is
there any feasible way to perform that?

BR,

Mauricio Lin.
