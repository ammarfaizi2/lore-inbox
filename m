Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTJNCh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 22:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJNCh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 22:37:28 -0400
Received: from adsl-67-67-9-206.dsl.okcyok.swbell.net ([67.67.9.206]:30911
	"HELO homer.d-oh.org") by vger.kernel.org with SMTP id S262168AbTJNChZ
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 13 Oct 2003 22:37:25 -0400
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: "Hans Reiser" <reiser@namesys.com>
Cc: "jw schultz" <jw@pegasys.ws>,
       "Linux Kernel Mailing List" <Linux-Kernel@Vger.Kernel.ORG>,
       <vs@namesys.com>
Subject: RE: ReiserFS patch for updating ctimes of renamed files
Date: Mon, 13 Oct 2003 21:37:24 -0500
Message-ID: <JIEIIHMANOCFHDAAHBHOMEMEDAAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F8A6646.3070206@namesys.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

Yes, I agree with J.W.  However, I also think that Andrew has a good point
in that the behavior across Linux filesystems (ReiserFS, ext2, ext3, minix,
etc.) should be consistent.  Either they should all update ctime during
renames, or none of them should.

Anyway, I'll try to work with the GNU tar maintainer to get this problem in
tar fixed.  It'll probably be a lot harder to fix in tar than to have
ReiserFS update ctimes since it'll require major changes in
the --listed-incremental snapshot files.  However, if you don't think it's a
good idea to make these changes to ReiserFS then we'll just work on fixing
up tar.

Thanks,

Alex

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Hans Reiser
Sent: Monday, October 13, 2003 3:46 AM
To: Alex Adriaanse
Cc: jw schultz; Linux Kernel Mailing List; vs@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files


Alex, are you convinced by jw?  (I think I am.)  Would you be willing to
submit a patch for tar instead?

Hans

jw schultz wrote:

>On Mon, Oct 13, 2003 at 09:49:20AM +0400, Hans Reiser wrote:
>
>
> In theory it is cleaner and purer to do it the way we did. In practice,
>
>>Alex's problem seems like a real one, and I don't know how hard it is to
>>change tar to do the right thing.  We'll discuss it in a small seminar
>>today.
>>
>>
>
>Updating ctime does seem messy and a bit irrelevant for the
>atomic rename.  You are modifying the directories not the
>fricken file. This isn't DOS!  But it would seem he does
>indeed have an issue although i'm not sure what.  I've never
>used the listed-incremental option of tar and since the
>manpage is incomplete <rant deleted> i don't know what it
>actually does.  However, i have found the use of ctime to be
>terribly unreliable for file management and given what the
>standards have to say on the issue it sounds like tar is
>being abused or has a bug.
>
>
>
>


--
Hans


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

