Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTETL4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTETL4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:56:22 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:49869 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263729AbTETL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:56:21 -0400
Date: Tue, 20 May 2003 09:39:33 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Riley Williams <Riley@Williams.Name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: try_then_request_module
Message-ID: <20030520093933.O659@nightmaster.csn.tu-chemnitz.de>
References: <20030519110832.G626@nightmaster.csn.tu-chemnitz.de> <BKEGKPICNAKILKJKMHCAOEPLDAAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <BKEGKPICNAKILKJKMHCAOEPLDAAA.Riley@Williams.Name>; from Riley@Williams.Name on Mon, May 19, 2003 at 07:50:02PM +0100
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19I5vj-0000nB-00*3fhPCoP54a6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riley,

On Mon, May 19, 2003 at 07:50:02PM +0100, Riley Williams wrote:
>  >    int module_loaded_flag=0;

Tell that we don't know, whether the module is loaded
>  > retry_with_module_loaded:
>  >    
>  >    /* search code */

Do the search.    

>  >    if (!module_loaded_flag && !found) {

Test, whether we did not yet explicitly load the module and not
found the entry either.

>  >       module_loaded_flag=1;

Tell that we loaded it (if we cannot load it, then we fall
through).

>  >       if (!request_module(bla))
>  >          goto retry_with_module_loaded;

Restart search after successful module load.

>  >    }
>  >    return found;

> Out of curiosity, what exactly is the purpose of the goto in the
> above code? Since we set module_loaded_flag just prior to it, the
> first if statement must fail after the goto, so we just fall down
> to where we would have been without the goto.
 
That is intended. I just reuse the search code here instead of
duplicating it. 

Since I load the module to broaden my search range, I can also
try to load the module there. Without module support this goto
will never execute and most of that code there compiled away.

That's why I consider try_then_request_module() not needed.
But people seem to have big problems with using gotos and still
reading the code (although it's quite common in the kernel), so
try_then_request_module() might solve this *social* problem ;-)

Regards

Ingo Oeser
