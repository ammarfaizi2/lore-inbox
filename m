Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280245AbRKEFzg>; Mon, 5 Nov 2001 00:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280254AbRKEFz0>; Mon, 5 Nov 2001 00:55:26 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:26117 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280245AbRKEFzI>;
	Mon, 5 Nov 2001 00:55:08 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111050554.fA55swt273156@saturn.cs.uml.edu>
Subject: Re: [Ext2-devel] disk throughput
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Mon, 5 Nov 2001 00:54:58 -0500 (EST)
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org (lkml),
        ext2-devel@lists.sourceforge.net
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> from "Mike Fedyk" at Nov 04, 2001 07:32:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk writes:
> On Sun, Nov 04, 2001 at 06:13:19PM -0800, Andrew Morton wrote:

>> All well and good, and still a WIP.  But by far the most dramatic
>> speedups come from disabling ext2's policy of placing new directories
>> in a different blockgroup from the parent:
> [snip]
>> A significant thing here is the improvement in read performance as well
>> as writes.  All of the other speedup changes only affect writes.
>>
>> We are paying an extremely heavy price for placing directories in
>> different block groups from their parent.  Why do we do this, and
>> is it worth the cost?
>
> My God!  I'm no kernel hacker, but I would think the first thing
> you would want to do is keep similar data (in this case similar
> because of proximity in the dir tree) as close as possible to
> reduce seeking...

By putting directories far apart, you leave room for regular
files (added at some future time) to be packed close together.

I'm sure your benchmark doesn't fill directories with files
by adding a few files every day over a period of many months.
Think about projects under your home directory though.
