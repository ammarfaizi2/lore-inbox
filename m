Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267895AbTBVNFW>; Sat, 22 Feb 2003 08:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267896AbTBVNFW>; Sat, 22 Feb 2003 08:05:22 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:57230 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267895AbTBVNFU>; Sat, 22 Feb 2003 08:05:20 -0500
Date: Sat, 22 Feb 2003 11:06:57 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
Message-ID: <20030222110657.K629@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com> <20030219092046.458c2876.rddunlap@osdl.org> <1045692372.14268.9.camel@rth.ninka.net> <20030219214817.GD4977@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030219214817.GD4977@gtf.org>; from jgarzik@pobox.com on Wed, Feb 19, 2003 at 04:48:17PM -0500
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18mZV1-0001j8-00*55cSCJVqvgw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Wed, Feb 19, 2003 at 04:48:17PM -0500, Jeff Garzik wrote:
> /me wishes gcc would let the user application define printf formats
> for arbitrary [non-struct] user data types...

Better might be to change the whole protocol over to sth. like
that what PASCAL does but still print into a string. GCC is
type checking and enumerating the arguments for printf and scanf
anyway so it could also supply that information to the functions
itself, if they have a special attribute (__new_style_printf__).

If GCC needs to print/scan a type, it composes a function name
similiar to C++ signatures and calls this. If it does not exists,
it warns at compile time. The decomposition of constant strings
is done at compile time. There is also a GCC function, which does
it at runtime. This is no problem, since index into type name
table and number of arguments is on the stack along with the
varargs. So we only need to specify the numeric format like
hex/numeric, leading zero fill or not, space fill and so on. No
more fiddling with word sizes and signedness.

Even structures may be printed/assigned, by defining a start_level,
next_item and end_level function to print the equivalent of '{'
',' and '}' in the structure.

I would really vote for such an extension to GCC, since doing
this without the help of GCC is error prone (because it's not
really typesafe) and leads to many problems. 

That way even the config file parsers get much simpler, because
you can define the lexical rules with scanf already today and now
you can even define a simple grammar likewise ;-)

But this is not the right list for this, but I just wanted to
braindump that ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
