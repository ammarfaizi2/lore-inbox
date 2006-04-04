Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWDDROU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWDDROU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDDROU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:14:20 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:9375 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1750700AbWDDROU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:14:20 -0400
Message-ID: <4432A9DE.9090902@myrealbox.com>
Date: Tue, 04 Apr 2006 10:16:14 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: tridge@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
References: <17452.50912.404106.256236@samba.org> <20060331095711.GK14022@suse.de> <Pine.LNX.4.64.0603311110540.27203@g5.osdl.org> <20060331194012.GE14022@suse.de>
In-Reply-To: <20060331194012.GE14022@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Mar 31 2006, Linus Torvalds wrote:
> 
>>
>>On Fri, 31 Mar 2006, Jens Axboe wrote:
>>
>>>>  ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned flags);
>>>
>>>I definitely see some valid reasons for adding a file offset instead of
>>>using ->f_pos, I'll leave that decision up to Linus though. Linus?
>>
>>I think a file offset is fine, the one thing holding me back was just the 
>>interface. One file offset per fd? Or just have the rule that the file 
>>offset is for the "non-pipe" device?
> 
> 
> Intuitively, I'd expect the offset to be tied to the non-pipe if I were
> to eg see this for the first time. So my vote would go for that.
> 

Eee!  That means that splice(file_fd, pipe_fd, 1000) and splice(pipe_fd, 
file_fd, 1000) have different semantics.  It also would seem to prevent 
ever implementing direct file-to-file splicing.

--Andy
