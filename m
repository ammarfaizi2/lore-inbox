Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWGLCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWGLCCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 22:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWGLCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 22:02:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:57311 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932344AbWGLCCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 22:02:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=p1A9tu2mNcp+CqS8JJOxBicziCg6OLIr3WSyImLuz8W8Z3y8+oF+K5cJ3smzkefAkWlr5CNaGZkRnLV8Q5eSUkvg+lJsfPUg/hRdlkvcitywxnJPZ9bu8rhs0XIksU8vKIkxy4rC7N83EEvRugZKz+7FplryKVQmiphCIQDIrpk=
Message-ID: <ed5aea430607111902i91b9e92s784ce8d2103f1b4e@mail.gmail.com>
Date: Tue, 11 Jul 2006 20:02:37 -0600
From: "David Mosberger-Tang" <David.Mosberger@acm.org>
To: "Jeremy Higdon" <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Jes Sorensen" <jes@sgi.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, "John Daiker" <jdaiker@osdl.org>,
       "John Hawkes" <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Jack Steiner" <steiner@sgi.com>,
       "Dan Higgins" <djh@sgi.com>
In-Reply-To: <20060711183754.GB734242@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <1151578928.23785.0.camel@localhost.localdomain>
	 <44A3AFFB.2000203@sgi.com>
	 <1151578513.3122.22.camel@laptopd505.fenrus.org>
	 <20060708001427.GA723842@sgi.com>
	 <1152340963.3120.0.camel@laptopd505.fenrus.org>
	 <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com>
	 <20060710202228.GA732959@sgi.com>
	 <ed5aea430607102001g514bfa97jf82c25a038e9c436@mail.gmail.com>
	 <20060711183754.GB734242@sgi.com>
X-Google-Sender-Auth: cb5224a2ec8d856d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Jeremy Higdon <jeremy@sgi.com> wrote:

> Okay.  So what do you think about changing the value in param.h from
> 1024, so that it matches the new common value of 250, or is it best
> just to leave it at 1024 and let applications that use it get the wrong
> result?

In my opinion, HZ needs to be a constant, since otherwise you could
break perfectly fine existing code (e.g., code which statically
initializes a variable with HZ and then picks up the correct frequency
from sysconf) and if you have to pick a particular constant, it seems
reasonable to me to pick the most commonly used frequency (which
appears to be 250Hz at the moment).

  --david
-- 
Mosberger Consulting LLC, http://www.mosberger-consulting.com/
