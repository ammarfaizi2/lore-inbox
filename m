Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSFQUH5>; Mon, 17 Jun 2002 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSFQUH4>; Mon, 17 Jun 2002 16:07:56 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:51197 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316969AbSFQUHz>; Mon, 17 Jun 2002 16:07:55 -0400
Date: Mon, 17 Jun 2002 16:07:57 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
Message-ID: <20020617160757.C1457@redhat.com>
References: <Pine.LNX.4.44.0206171246270.31265-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206171246270.31265-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Mon, Jun 17, 2002 at 01:03:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 01:03:15PM -0700, dean gaudet wrote:
> 3x slower with the two cats in parallel.

cat uses an incredibly small buffer for file io (4KB on x86), so 
running multiple cats in parallel will simply thrash your disk.  
What you really want is to run the open()s in parallel and the 
read()s sequentially (or in parallel with a large buffer to cut 
down on the seek cost).

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
