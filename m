Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTDRJmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTDRJmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:42:04 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:54171 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262993AbTDRJmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:42:03 -0400
Date: Fri, 18 Apr 2003 05:50:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] only use 48-bit lba when necessary
To: "linux-kernel@horizon.com" <linux-kernel@horizon.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304180553_MC3-1-34EE-10DA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>   The operands of & can be evaluated in any order, while && requires
>> left-to-right and does not evaluate the right operand if the left one
>> is false.  Only the simplest cases could possibly generate the same
>> code.
>
> The code must execute AS IF the right operand is only evaluated if the left
> operand is true.
>
> If an optimizer can prove that evaluating an operand has no side effects
> (which a halfway-decent optimizer can usually do for simple expressions),
> then it is free to evaluate it in any way that will produce the same
> result.


  No, that's not quite right.  Take this code for example:

   struct foo *bar;

   if (bar && bar->baz == 6) /* something */;

If bar were zero, then evaluating the right side of the && would cause
a fault.  (This is not a side effect.)

  So the AS IF part if your statement is right but you have to consider
more than just side effects.

 --
 Chuck
