Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVACC0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVACC0E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 21:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVACC0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 21:26:04 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:31094 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261280AbVACC0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 21:26:02 -0500
Message-ID: <41D8AD37.20008@sbcglobal.net>
Date: Sun, 02 Jan 2005 21:25:59 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: why clear_buffer_uptodate in end_buffer_write_sync on write error?
References: <41D8AB74.7010409@sbcglobal.net>
In-Reply-To: <41D8AB74.7010409@sbcglobal.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, ok this makes sense for the sync case, but what about the async 
case?  Should clear_buffer_uptodate be called in end_buffer_async_write? 
  How is the error going to be reported to the user, particularly in the 
case of a memory mapped file?  Shouldn't the system try to write that 
page again?

Robert W. Fuller wrote:
> I'm trying to understand the file systems.  I'm making good progress, 
> but I don't get this.  If the buffer is marked not up to date because 
> the write failed, won't this cause block_prepare_write to try and read 
> the buffer using ll_rw_block thereby overwriting the data that couldn't 
> be written?  Is this desirable?  Perhaps I'm confused?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
