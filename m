Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSF1NuF>; Fri, 28 Jun 2002 09:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSF1NuC>; Fri, 28 Jun 2002 09:50:02 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:45065 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317395AbSF1NuB>; Fri, 28 Jun 2002 09:50:01 -0400
Date: Fri, 28 Jun 2002 11:33:10 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: "Hurwitz Justin W." <hurwitz@lanl.gov>, linux-kernel@vger.kernel.org
Subject: Re: zero-copy networking & a performance drop
Message-ID: <20020628113310.D647@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0206271545220.17078-100000@alvie-mail.lanl.gov> <Pine.LNX.4.33.0206271513320.13651-100000@w-nivedita2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0206271513320.13651-100000@w-nivedita2.des.beaverton.ibm.com>; from niv@us.ibm.com on Thu, Jun 27, 2002 at 03:33:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2002 at 03:33:33PM -0700, Nivedita Singhvi wrote:
>       - rx side processing can involve more work (stack length
>         is simply longer) and so can legitimately take longer.
> 	This is especially true when options and out of order
> 	packets are involved, and TCP fast path processing
> 	on the rx side isnt taken. (I had done a breakdown 
> 	of this based on some profiles last year, but dont
> 	have that at the moment)
 
Jupp, I think this is really true. Look at all the checking alone. 

Remember: We accept data from an untrusted source (network) which
   has lots of control information encoded with many of them
   being optional.

   -> This involves a lot of "parsing" (for binary streams,
      decoding might be better) of a complex language (TCP/IP ;-))
      with many optional elements (read: lots of branches in the
      language tree).
      
On sending data, we have all the information trusted, because we
checked that already, as the user sets it. With sendfile, we have
even trusted and mapped data (because we just paged it in before).

If we take this into account, rx MUST be always slower, or tx
isn't really optimized yet.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
