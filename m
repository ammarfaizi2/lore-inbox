Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUDTIJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUDTIJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 04:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDTIJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 04:09:54 -0400
Received: from ip-64-32-173-177.dsl.sca.megapath.net ([64.32.173.177]:62125
	"EHLO mail.zaptech.com") by vger.kernel.org with ESMTP
	id S262347AbUDTIJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 04:09:51 -0400
Message-ID: <4084DAFB.7060805@zaptech.com>
Date: Tue, 20 Apr 2004 01:10:35 -0700
From: Fred Shaul <info@zaptech.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: info@howtolabs.net
Subject: Re: 2.5.66-bk12 causes "rpm" errors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, I just got this to happen with Fedora Core 1!

# uname -a
Linux bilbo.scalix.local 2.4.22-1.2115.nptl #1
Wed Oct 29 15:42:51 EST 2003 i686 i686 i386 GNU/Linux


Error I was having ...

# rpm -q rpm
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily
unavailable (11)
error: cannot open Packages database in /var/lib/rpm
package rpm is not installed

Now it works when the following is done!!!!!

# rm /var/lib/rpm/__*

# export LD_ASSUME_KERNEL=2.2.5

# rpm -q rpm
rpm-4.2.1-0.30

Please cc any replies to me

- Fred Shaul
   zap technologies
   http://zaptech.com/

On 6 Apr 2003, Robert Love wrote:
> ok, based on messing around this morning with this, here's what i've 
> found.
> 
> (first, apologies to andrew morton; when i said his patch applied on 
> top of bk12, i was just confused. it's a "battle tactic". :-)
> 
> all of this is based on my RH 9 (shrike) box, running on a dell 
> inspiron 8100.
> 
> first, the rpm flaw exists using all three variations of the kernel i
>  tested:
> 
> 2.5.66 
> 2.5.66-bk12
> 2.5.66-bk12-mm (bk12 minus andrew's filemap patch)
> 
> the interesting part is that doing something simple like "rpm -q rpm"
>  works for a non-root user; it fails only when root tries it, even 
> though the operation is only a query. go figure.
> 
> next, backing out from rpm-4.2-0.69 to rpm-4.2-0.66 didn't seem to 
> fix the problem (at least, not for me -- a previous poster claimed 
> that it fixed it for him, but it didn't solve the problem here).
> 
> finally, using:
> 
> LD_ASSUME_KERNEL=2.2.5 rpm -q rpm
> 
> solves the problem (at least under the 2.5.66-bk12-mm kernel i'm 
> running at the moment -- i'll assume it does the same under the 
> others).



