Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289078AbSAIXai>; Wed, 9 Jan 2002 18:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289081AbSAIXaV>; Wed, 9 Jan 2002 18:30:21 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:60544 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289080AbSAIXaI>;
	Wed, 9 Jan 2002 18:30:08 -0500
Message-ID: <3C3CD304.9070704@acm.org>
Date: Wed, 09 Jan 2002 17:32:20 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Moving zlib so that others may use it
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a function that uses zlib in the kernel, and I know of 
other places zlib is used (ppp_deflate, jffs2, mcore).  I would expect 
more users to come along.

I would like to propose putting zlib in the lib directory and making it 
optionally compile if it is needed.  It's pretty easy to move the files 
around and make a few small changes to the code.  However, how do I 
configure such a thing?  I could add something like:

   if [ "$CONFIG_PPP_DEFLATE" = "y" ]; then
      define_tristate CONFIG_ZLIB y
   fi
   if [ "$CONFIG_PPP_DEFLATE" = "m" ]; then
      if [ "$CONFIG_ZLIB" != "y" ]; then
         define_tristate CONFIG_ZLIB m
      fi
   fi

to every place that uses it, or I could put something like:

   if [ "$CONFIG_JFFS2_FS" = "y" \
        -o "$CONFIG_PPP_DEFLATE" = "y" ]; then
      define_tristate CONFIG_ZLIB y
   else
      if [ "$CONFIG_JFFS2_FS" = "m" \
          -o "$CONFIG_PPP_DEFLATE" = "m" ]; then
         define_tristate CONFIG_ZLIB m
      fi
   fi

at the end of the config.  I would prefer the latter, but there is not 
an "end of config" place, you would have to put it at the end of every 
config.in (about 15 architectures right now).  I propose to add a 
Config.in to the lib directory that is sourced at the end of every 
config.in for the architectures.  I'll do the work if it's willing to be 
accepted into the kernel.

-Corey


