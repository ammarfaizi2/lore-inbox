Return-Path: <linux-kernel-owner+w=401wt.eu-S932670AbXAKXxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbXAKXxe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbXAKXxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:53:34 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:27268 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932670AbXAKXxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:53:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r1TbPgYVmMEscm/S8nXy8qOdJL6SDyYZ3+yGHNXQ4Z4dPPK7gcjFnF0wciPgSeI+RIShhviN7cl+cowOX9WlZZtDk1H1wzkTGUNbYgGiR2VNfsrVCnRWTHKNqrwWxd9yKhWWPR6BZibNRiKmQOkNAVyS78Oz3Q8IDA08IL/RI64=  ;
X-YMail-OSG: 3FjLnakVM1k6xtHZJor7kWYinzzHNsUrt0GZFyp.IeZm.DACON5aB2fufH5IL5fQhkIYMsb60eHsD0IiG24J76M5KRLr0hxX7JP0vI5cVacTpSS0x7ULIEWAsl4iV6mYpa5k49djqBOLjfo-
Message-ID: <45A6CDE3.90001@yahoo.com.au>
Date: Fri, 12 Jan 2007 10:53:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
CC: reiserfs-dev@namesys.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <200701110324.42920.vs@namesys.com> <45A58C33.4050909@yahoo.com.au> <200701111612.40701.vs@namesys.com>
In-Reply-To: <200701111612.40701.vs@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev wrote:
> Hello
> 
> On Thursday 11 January 2007 04:00, Nick Piggin wrote:

>>That's racy, unfortunately :P
>>
> 
> 
> Sorry, please, explain what is racy.
> reiserfs_truncate and reiserfs_release call that function after they have inode's mutex locked.

Calling truncate inside i_size (ie. vmtruncate_range is also racy), because
of the way that the pagefault side of the equation works (eg. truncate_count).

But if you're only calling truncate on files that are never mmapped, then I
think that race should disappear.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
