Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310667AbSCHDEi>; Thu, 7 Mar 2002 22:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSCHDE2>; Thu, 7 Mar 2002 22:04:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42506 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310667AbSCHDEJ>;
	Thu, 7 Mar 2002 22:04:09 -0500
Message-ID: <3C8829BD.4D1ECED@zip.com.au>
Date: Thu, 07 Mar 2002 19:02:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C880EFF.A0789715@zip.com.au>,
		<3C880EFF.A0789715@zip.com.au> <1044120155.1015527354@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> Where did truncate_list_pages unlock it?

                                if (*partial && (offset + 1) == start) {
                                        truncate_partial_page(page, *partial);
                                        *partial = 0;
                                } else 
                                        truncate_complete_page(page);

                                UnlockPage(page);
                        } else
                                wait_on_page(page);

It's either unlocked directly, or we wait for whoever locked
it (presumably I/O) to unlock it.

-
