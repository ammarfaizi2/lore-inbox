Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312487AbSCYS3S>; Mon, 25 Mar 2002 13:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSCYS3I>; Mon, 25 Mar 2002 13:29:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56741 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312493AbSCYS24>; Mon, 25 Mar 2002 13:28:56 -0500
Message-ID: <3C9F69F4.3010908@vnet.ibm.com>
Date: Mon, 25 Mar 2002 12:18:28 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: "J.D. Hood" <jdthood@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: proc_file_read() hack?
In-Reply-To: <20020323114004.92117.qmail@web10307.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.D. Hood wrote:

> I posted a patch which includes the following comment:
> 
> +			/*
> +			 * How to be a proc read function
> +			 * ------------------------------
[...]


How about applying my trivial patch and then adding this to your nice 
comment?

3) Set *start = an address outside the buffer.
    Put the data of the requested offset at *start.
    Return the number of bytes of data placed there.
    If this number is greater than zero and you
    didn't signal eof and the reader is prepared to
    take more data you will be called again with the
    requested offset advanced by the number ob tyes
    absorbed.

The code should still work with the other cases now that the hack is 
fixed.  Of course, rather than add 3), it would be better to re-word 2) 
(e.g. "Set *start = address of the buffer which may or may not be in the 
given buffer.).

There are cases where the data is available and need not be copied.  My 
code got simpler when I got rid of the need to copy my data around.

-todd




