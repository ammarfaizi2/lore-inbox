Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280952AbRKORZQ>; Thu, 15 Nov 2001 12:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280953AbRKORY7>; Thu, 15 Nov 2001 12:24:59 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:24312 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S280952AbRKORYh>; Thu, 15 Nov 2001 12:24:37 -0500
Date: Thu, 15 Nov 2001 17:24:29 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Numbers: ext2/ext3/reiser Performance (ext3 is slow)
Message-ID: <20011115172429.A14221@redhat.com>
In-Reply-To: <E162ZQN-00069u-00@fenrus.demon.nl> <Pine.LNX.4.40.0111101831440.14552-100000@omega.hbh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111101831440.14552-100000@omega.hbh.net>; from oktay.akbal@s-tec.de on Sat, Nov 10, 2001 at 06:41:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 10, 2001 at 06:41:15PM +0100, Oktay Akbal wrote:

> The question is, when to use what mode. I would use data=journal on my
> CVS-Archive, and maybe writeback on a news-server.
> But what to use for an database like mysql ?

For a database, your application will be specifying the write
ordering explicitly with fsync and/or O_SYNC.  For the filesystem to
try to sync its IO in addition to that is largely redundant.
writeback is entirely appriopriate for databases.

Remember, the key condition that ordered mode guards against is
finding stale blocks in the middle of recently-allocated files.  With
databases, that's not a huge concern.  Except during table creation,
most database writes are into existing allocated blocks; and the data
in the database is normally accessed directly only by a specified
database process, not by normal client processes, so any leaks that do
occur if the database extends its file won't be visible to normal
users.

Cheers,
 Stephen
