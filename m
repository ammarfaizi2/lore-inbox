Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUJXXoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUJXXoE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUJXXoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:44:04 -0400
Received: from smtp07.auna.com ([62.81.186.17]:33993 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261621AbUJXXn7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:43:59 -0400
Date: Sun, 24 Oct 2004 23:43:52 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: kbuild dependencies and layout
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1098661432l.6459l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I'm trying to make a small modification to the Kconfig files, but I can't
get the menu layout match what I want.

Say I want this logic:

menu "A support"
  config A_1
    tristate "A-1"
  config A_2
    tristate "A-2"
  config A_GENERIC_FEATURE_1
    bool "AF1"
    depends on A_1 || A_2
  config A_GENERIC_FEATURE_2
    bool "AF2"
    depends on A_1 || A_2
endmenu

A_GENERIC_FEATURE_1 is valid for both submodels. Logic is right, but
gconfig insists on putting AF1 as a subentry of A_2, instead of hanging
it in the menu. I would like:

  A support
   \- A-1
   \- A-2
   \- AF1 (visible only when A-1 or A-2 are selected)
   \- AF2 (visible only when A-1 or A-2 are selected)

but I get

  A support
   \- A-1
   \- A-2
      \- AF1 (visible only when A-1 or A-2 are selected)
      \- AF2 (visible only when A-1 or A-2 are selected)

(ie, both optional features haged on A-2)

What am I doing wrong ? Is there any way to defeat the auto-layout
based on depedencies of kbuild ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


