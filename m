Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290701AbSAYPA0>; Fri, 25 Jan 2002 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290702AbSAYPAR>; Fri, 25 Jan 2002 10:00:17 -0500
Received: from sushi.toad.net ([162.33.130.105]:4320 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S290701AbSAYPAK>;
	Fri, 25 Jan 2002 10:00:10 -0500
Subject: Re: proc_file_read bug?
From: Thomas Hood <jdthood@mail.com>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <jer8oesdv4.fsf@sykes.suse.de>
In-Reply-To: <1011965794.1338.6.camel@thanatos> 
	<jer8oesdv4.fsf@sykes.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Jan 2002 10:00:12 -0500
Message-Id: <1011970816.1342.10.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 09:29, Andreas Schwab wrote:
> |>                 /* This is a hack to allow mangling of file pos independent
> |>                  * of actual bytes read.  Simply place the data at page,
> |>                  * return the bytes, and set `start' to the desired offset
> |>                  * as an unsigned int. - Paul.Russell@rustcorp.com.au
> |>                  */

> It is documented, RTFC.

Comment or Code?  The comment is somewhat ambiguous and incorrect.

Reading the code, I take it that "start" is either a pointer into
the buffer where the string of n data bytes starts, or else
(when it is assigned a value less than the beginning of the buffer)
it is a special value by which the file offset is to be adjusted,
instead of n.  Thus the comment might be clarified:
    /* 
     * This is a hack to allow adjusting the file offset
     * by a number different from the number of bytes read.
     * Simply place the data at page, return the number of
     * bytes read, and set "start" to the (signed long) amount
     * by which the file offset is to be increased or
     * decreased
     */

My question then is: why would one want to adjust the file
offset other than by +n?

--
Thomas

