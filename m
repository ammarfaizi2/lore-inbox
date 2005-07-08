Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVGHOs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVGHOs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVGHOs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:48:28 -0400
Received: from web34413.mail.mud.yahoo.com ([66.163.178.162]:49572 "HELO
	web34413.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262680AbVGHOs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:48:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XilgJkMOtRHsK9sDqR4JeSuSBS2dOl/YspBHnPIHtF+mqa7DwfPO1pEVUVBYTrt8G8kzplH16ne4+FyeDtkiB4oW8Ed8ykURcEVk1zXYvZAdXm04+kZD9/zK+flu+g3nWHSXGNxXG70kHVNgzaNA9+YENH4728RCclRziKdL1kU=  ;
Message-ID: <20050708144823.70503.qmail@web34413.mail.mud.yahoo.com>
Date: Fri, 8 Jul 2005 07:48:22 -0700 (PDT)
From: <jscottkasten@yahoo.com>
Subject: Re: function Name
To: raja <vnagaraju@effigent.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42CE1945.7080909@effigent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- raja <vnagaraju@effigent.net> wrote:

> hi,
>    I am writing a function that takes the return
> value of the another 
> function and gives the  status of the function.
> if
>    error("functionName",arguments)
> here the function with Name "functionName " is to be
> executed with the 
> corresponding argunents.But by knowing the function
> name how can i get 
> the address if that function and how can i execute
> the function with the 
> arguments.
> 

Dude, this is not the right forum for these types of
questions.  You need to look at some good general
texts.  I don't know if you can get a copy of Steven's
or other general Unix programming text, but that's
what would help you the most.  Anyway, here's an
example for you.  The C compiler in general treats a
function name as a type of pointer, similar to an
array base pointer in that you cannot modify it, but
you can de-reference it.

/* Crude demo program for calling a function
 * by indirect means and supplying arguments.
 *
 * Yes, it's GPL.  :-)
 */

#include <stdio.h>

int foo(char *message)
{
  int error = 0;

  if (message)
    printf("%s\n", message);
  else
    error = 1;

  return error;
}

int call_a_function(int (*func)(char *), char *arg)
{
  return (*func)(arg);
} 

int main(int argc, char *argv[])
{
  int (*func)(char *);
  char *arg;

  if (argc == 2) {
    func = foo;
    arg  = argv[1];
    return call_a_function(func, arg);
  } else {
    return 1;
  }
}


