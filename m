Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312518AbSCYTpA>; Mon, 25 Mar 2002 14:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312521AbSCYTov>; Mon, 25 Mar 2002 14:44:51 -0500
Received: from sushi.toad.net ([162.33.130.105]:32137 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S312518AbSCYToi>;
	Mon, 25 Mar 2002 14:44:38 -0500
Subject: Re: proc_file_read() hack?
From: Thomas Hood <jdthood@mail.com>
To: Todd Inglett <tinglett@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C9F69F4.3010908@vnet.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Mar 2002 14:45:55 -0500
Message-Id: <1017085557.5263.335.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, your method #3 conflicts with methods #0 through #2,
which exhaust the range of possible values that may be returned
in *start.  Any value greater than buffer is regarded as being
"within the buffer".

Introducing method #1 was a bad idea because this hack made it
impossible cleanly to implement what you suggest.

--
Thomas Hood

On Mon, 2002-03-25 at 13:18, Todd Inglett wrote:
> How about applying my trivial patch and then adding this to your nice 
> comment?
> 
> 3) Set *start = an address outside the buffer.
>     Put the data of the requested offset at *start.
>     Return the number of bytes of data placed there.
>     If this number is greater than zero and you
>     didn't signal eof and the reader is prepared to
>     take more data you will be called again with the
>     requested offset advanced by the number ob tyes
>     absorbed.
> 
> The code should still work with the other cases now that the hack is 
> fixed.  Of course, rather than add 3), it would be better to re-word 2) 
> (e.g. "Set *start = address of the buffer which may or may not be in the 
> given buffer.).
> 
> There are cases where the data is available and need not be copied.  My 
> code got simpler when I got rid of the need to copy my data around.


