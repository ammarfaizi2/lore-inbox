Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUFXG75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUFXG75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUFXG75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:59:57 -0400
Received: from mproxy.gmail.com ([216.239.56.240]:54291 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263923AbUFXG74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:59:56 -0400
Message-ID: <7c07cd6904062323593201a558@mail.gmail.com>
Date: Thu, 24 Jun 2004 12:29:55 +0530
From: abhijit <slashdev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: do_gettimeofday( ) precision?
In-Reply-To: <7c07cd6904062323437ff6ac69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7c07cd69040623082311234157@mail.gmail.com> <Pine.GSO.4.58.0406231747300.2009@mion.elka.pw.edu.pl> <7c07cd6904062323437ff6ac69@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 12:13:11 +0530, abhijit <slashdev@gmail.com> wrote:
>
> basically i want some counter w/ microsend resolution that fits into 32 bits.
> couple of possible solutions come to my mind:
> 
> [1]  use TSC and convert it to microsec
> [2] use get_timeofday( ) and convert to microsec
> [3] use xtime variable directly and convert to microsec
> (any other ways?)
> 
> conversion in [1] will be costly (a div involved).
> conversion in [2]/[3] can be done using bit operators. (usec|sec << 20)
> but [2] will incur function call overhead which i'd like to avoid.
> 
> so is using xtime directly ok and reliable?

ok. after reading up the source, i think xtime isn;t updated frequently and will
not have the required resolution :( so calling do_gettimeofday() seems the only
way out (unless somebody has any other idea).

btw why isn't do_gettimeofday( ) declared as "inline". so its bit
cheaper to call
especially where you are timestamping (say packets) often.

thanks
abhijit
