Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTLUXqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTLUXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 18:46:47 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:37898 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264245AbTLUXqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 18:46:45 -0500
Message-ID: <3FE631EF.7080909@kolumbus.fi>
Date: Mon, 22 Dec 2003 01:51:11 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Slusky <sluskyb@paranoiacs.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jariruusu@users.sourceforge.net
Subject: Re: [PATCH] loop.c patches, take two
References: <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org> <20031102204624.GA5740@fukurou.paranoiacs.org> <20031221195534.GA4721@fukurou.paranoiacs.org> <3FE6076B.3090908@kolumbus.fi> <20031221211201.GC4721@fukurou.paranoiacs.org> <3FE62617.10604@kolumbus.fi> <20031221230522.GD4721@fukurou.paranoiacs.org>
In-Reply-To: <20031221230522.GD4721@fukurou.paranoiacs.org>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 22.12.2003 01:48:47,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 22.12.2003 01:47:56,
	Serialize complete at 22.12.2003 01:47:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ben Slusky wrote:

>On Mon, 22 Dec 2003 01:00:39 +0200, Mika Penttil? wrote:
>  
>
>>AFAICS, this code path is never taken. You don't queue block device writes 
>>for the loop thread.
>>    
>>
>
>Yes I do, in loop_end_io_transfer. If we allocated fewer pages for the copy
>bio than contained in the original bio, then those pages are recycled for
>the next write.
>
>@@ -413,7 +411,7 @@ static int loop_end_io_transfer(struct b
> 	if (bio->bi_size)
> 		return 1;
> 
>-	if (err || bio_rw(bio) == WRITE) {
>+	if (err || (bio_rw(bio) == WRITE && bio->bi_vcnt == rbh->bi_vcnt)) {
> 		bio_endio(rbh, rbh->bi_size, err);
> 		if (atomic_dec_and_test(&lo->lo_pending))
> 			up(&lo->lo_bh_mutex);
>  
>
I see, subtle...

--Mika


