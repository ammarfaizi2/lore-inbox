Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUFKQsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUFKQsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUFKQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:46:28 -0400
Received: from email.careercast.com ([216.39.101.233]:44513 "HELO
	email.careercast.com") by vger.kernel.org with SMTP id S264154AbUFKQpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:45:39 -0400
Subject: Re: 2.6 vm/elevator loading down disks where 2.4 does not
From: Clint Byrum <cbyrum@spamaps.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040609162548.63d69b78.akpm@osdl.org>
References: <1086724300.5467.161.camel@localhost>
	 <20040609162548.63d69b78.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086972336.29458.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 09:45:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 16:25, Andrew Morton wrote:
> Possibly a memory zone problem.  Could you try booting with "mem=896m" on
> the kernel command line, see how that affects things?

This took a while longer to try, as I didn't want to unfairly test it
against a box with 1G of RAM. So I rebooted my 2.4.23 and 2.6.7-rc3 test
boxes with mem=896m. No change in the 5:1 ratio when comparing 2.6's
disk reads to 2.4's. Of course, both boxes ended up reading from the
disk more often, as they had less RAM for cache. I was unable to run a
long test as I did before, but I'm confident the 3 hours I did run tests
for show that this isn't a memory zone problem.

I still think this behavior is happening because useful pages are being
removed from the page cache too soon. Maybe this is happening because of
excessive readahead?

-cb

