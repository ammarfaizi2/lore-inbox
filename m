Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbUL3Alo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUL3Alo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUL3Ajs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:39:48 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:26586 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261474AbUL3Aiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:38:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=g/mKZ1l1DVDT+8YSlEvCfKJgQgjntxhzDycBfcfNOx6BB/Vq7533CpV6wUtvI6pxgIJWvM60NXamPRRYgtJIF6fXjhFSt4Ltoq9VO3vk9OvAumKCIlUMzF0gYk/+GovnQ8nV6amjzZqweSxcm+tTPpAfwSPLRilHt25+6Fl4pe8=
Message-ID: <41D34E16.2040503@gmail.com>
Date: Thu, 30 Dec 2004 01:38:46 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: include/linux/ipv6.h  error?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inet_sk(__sk) returns pointer to inet_sock structure which has pinet6 
field defined
or not defined depending on kernel configuration during compilation time

#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
        struct ipv6_pinfo       *pinet6;
#endif

the function below causes compilation error in kernel configs with 
neither CONFIG_IPV6 nor
CONFIG_IPV6_MODULE defined.

should these functions be included between
#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)

static inline struct ipv6_pinfo * inet6_sk(const struct sock *__sk)
{
        return inet_sk(__sk)->pinet6;
}

static inline struct raw6_opt * raw6_sk(const struct sock *__sk)
{
        return &((struct raw6_sock *)__sk)->raw6;
}
#endif


?? or should the #ifdef directive be removed from ipv6.h header file?


regards
-mb
