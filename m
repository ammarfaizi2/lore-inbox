Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVA0LPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVA0LPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVA0LPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:15:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46863 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262569AbVA0LB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:01:29 -0500
Date: Thu, 27 Jan 2005 12:01:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [RFC: 2.6 patch] drivers/acpi/: possible cleanups
Message-ID: <20050127110125.GE28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I'm getting flamed to death:
This patch isn't meant for being immediately applied.

This patch makes all needlessly global code under drivers/acpi/ static.
Please review this patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/ac.c                   |   18 ++---
 drivers/acpi/battery.c              |    2 
 drivers/acpi/button.c               |    4 -
 drivers/acpi/container.c            |    4 -
 drivers/acpi/debug.c                |    4 -
 drivers/acpi/dispatcher/dsfield.c   |    2 
 drivers/acpi/dispatcher/dsinit.c    |    2 
 drivers/acpi/dispatcher/dsmthdat.c  |   10 ++-
 drivers/acpi/dispatcher/dsobject.c  |    2 
 drivers/acpi/dispatcher/dsopcode.c  |    4 -
 drivers/acpi/dispatcher/dswload.c   |   12 +++
 drivers/acpi/ec.c                   |    2 
 drivers/acpi/events/evevent.c       |   11 ++-
 drivers/acpi/events/evgpe.c         |    6 +
 drivers/acpi/events/evregion.c      |   11 ++-
 drivers/acpi/executer/exconfig.c    |    2 
 drivers/acpi/executer/exconvrt.c    |    2 
 drivers/acpi/executer/exfldio.c     |    8 +-
 drivers/acpi/executer/exmutex.c     |    2 
 drivers/acpi/executer/exnames.c     |    4 -
 drivers/acpi/executer/exoparg6.c    |    2 
 drivers/acpi/executer/exresolv.c    |    6 +
 drivers/acpi/executer/exresop.c     |    2 
 drivers/acpi/executer/exstore.c     |    7 +-
 drivers/acpi/executer/exutils.c     |    2 
 drivers/acpi/fan.c                  |   14 ++--
 drivers/acpi/hardware/hwgpe.c       |    2 
 drivers/acpi/ibm_acpi.c             |    4 -
 drivers/acpi/namespace/nsalloc.c    |    2 
 drivers/acpi/namespace/nseval.c     |   11 ++-
 drivers/acpi/namespace/nsinit.c     |   17 ++++-
 drivers/acpi/namespace/nsload.c     |    2 
 drivers/acpi/namespace/nsnames.c    |    2 
 drivers/acpi/namespace/nsparse.c    |    2 
 drivers/acpi/namespace/nsutils.c    |   14 +++-
 drivers/acpi/osl.c                  |   10 +--
 drivers/acpi/parser/psargs.c        |    4 -
 drivers/acpi/parser/psopcode.c      |    2 
 drivers/acpi/parser/psparse.c       |    8 +-
 drivers/acpi/parser/pswalk.c        |    4 -
 drivers/acpi/pci_bind.c             |    6 +
 drivers/acpi/pci_irq.c              |    4 -
 drivers/acpi/power.c                |   10 +--
 drivers/acpi/processor_core.c       |    6 -
 drivers/acpi/processor_thermal.c    |    2 
 drivers/acpi/processor_throttling.c |    2 
 drivers/acpi/scan.c                 |   12 ++-
 drivers/acpi/tables/tbget.c         |   14 +++-
 drivers/acpi/tables/tbgetall.c      |    4 -
 drivers/acpi/tables/tbxfroot.c      |    8 +-
 drivers/acpi/thermal.c              |    2 
 drivers/acpi/toshiba_acpi.c         |    2 
 drivers/acpi/utilities/utalloc.c    |   23 ++++++-
 drivers/acpi/utilities/utcopy.c     |   10 +--
 drivers/acpi/utilities/utdelete.c   |    2 
 drivers/acpi/utilities/utinit.c     |    2 
 drivers/acpi/utilities/utmisc.c     |   19 ++++-
 drivers/acpi/utilities/utobject.c   |    6 -
 drivers/acpi/video.c                |    2 
 include/acpi/acdispat.h             |   57 -----------------
 include/acpi/acevents.h             |   27 --------
 include/acpi/achware.h              |    5 -
 include/acpi/acinterp.h             |   79 ------------------------
 include/acpi/acnamesp.h             |   61 ------------------
 include/acpi/acparser.h             |   37 -----------
 include/acpi/acpi_bus.h             |    1 
 include/acpi/acpi_drivers.h         |    1 
 include/acpi/actables.h             |   32 ---------
 include/acpi/acutils.h              |   92 ----------------------------
 include/acpi/processor.h            |    2 
 include/linux/acpi.h                |    2 
 71 files changed, 241 insertions(+), 520 deletions(-)

--- linux-2.6.11-rc2-mm1-full/drivers/acpi/ac.c.old	2005-01-26 19:55:44.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/ac.c	2005-01-26 19:57:37.000000000 +0100
@@ -51,8 +51,8 @@
 MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-int acpi_ac_add (struct acpi_device *device);
-int acpi_ac_remove (struct acpi_device *device, int type);
+static int acpi_ac_add (struct acpi_device *device);
+static int acpi_ac_remove (struct acpi_device *device, int type);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_ac_driver = {
@@ -108,9 +108,9 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ac_dir;
+static struct proc_dir_entry	*acpi_ac_dir;
 
-int acpi_ac_seq_show(struct seq_file *seq, void *offset)
+static int acpi_ac_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_ac		*ac = (struct acpi_ac *) seq->private;
 
@@ -200,7 +200,7 @@
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-void
+static void
 acpi_ac_notify (
 	acpi_handle		handle,
 	u32			event,
@@ -232,7 +232,7 @@
 }
 
 
-int
+static int
 acpi_ac_add (
 	struct acpi_device	*device)
 {
@@ -286,7 +286,7 @@
 }
 
 
-int
+static int
 acpi_ac_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -315,7 +315,7 @@
 }
 
 
-int __init
+static int __init
 acpi_ac_init (void)
 {
 	int			result = 0;
@@ -337,7 +337,7 @@
 }
 
 
-void __exit
+static void __exit
 acpi_ac_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_ac_exit");
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/battery.c.old	2005-01-26 19:57:52.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/battery.c	2005-01-26 19:58:07.000000000 +0100
@@ -341,7 +341,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_battery_dir;
+static struct proc_dir_entry	*acpi_battery_dir;
 static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 {
 	int			result = 0;
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/button.c.old	2005-01-26 19:58:24.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/button.c	2005-01-26 19:58:34.000000000 +0100
@@ -275,7 +275,7 @@
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-void
+static void
 acpi_button_notify (
 	acpi_handle		handle,
 	u32			event,
@@ -302,7 +302,7 @@
 }
 
 
-acpi_status
+static acpi_status
 acpi_button_notify_fixed (
 	void			*data)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/container.c.old	2005-01-26 19:58:51.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/container.c	2005-01-26 19:59:05.000000000 +0100
@@ -255,7 +255,7 @@
 }
 
 
-int __init
+static int __init
 acpi_container_init(void)
 {
 	int	result = 0;
@@ -276,7 +276,7 @@
 	return(0);
 }
 
-void __exit
+static void __exit
 acpi_container_exit(void)
 {
 	int			action = UNINSTALL_NOTIFY_HANDLER;
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/debug.c.old	2005-01-26 19:59:19.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/debug.c	2005-01-26 19:59:33.000000000 +0100
@@ -35,7 +35,7 @@
 };
 #define ACPI_DEBUG_INIT(v)	{ .name = #v, .value = v }
 
-const struct acpi_dlayer acpi_debug_layers[] =
+static const struct acpi_dlayer acpi_debug_layers[] =
 {
 	ACPI_DEBUG_INIT(ACPI_UTILITIES),
 	ACPI_DEBUG_INIT(ACPI_HARDWARE),
@@ -53,7 +53,7 @@
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 };
 
-const struct acpi_dlevel acpi_debug_levels[] =
+static const struct acpi_dlevel acpi_debug_levels[] =
 {
 	ACPI_DEBUG_INIT(ACPI_LV_ERROR),
 	ACPI_DEBUG_INIT(ACPI_LV_WARN),
--- linux-2.6.11-rc2-mm1-full/include/acpi/acdispat.h.old	2005-01-26 20:00:04.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acdispat.h	2005-01-26 20:05:05.000000000 +0100
@@ -78,13 +78,6 @@
 /* dsopcode - support for late evaluation */
 
 acpi_status
-acpi_ds_execute_arguments (
-	struct acpi_namespace_node      *node,
-	struct acpi_namespace_node      *scope_node,
-	u32                             aml_length,
-	u8                              *aml_start);
-
-acpi_status
 acpi_ds_get_buffer_field_arguments (
 	union acpi_operand_object       *obj_desc);
 
@@ -101,15 +94,6 @@
 	union acpi_operand_object       *obj_desc);
 
 acpi_status
-acpi_ds_init_buffer_field (
-	u16                             aml_opcode,
-	union acpi_operand_object       *obj_desc,
-	union acpi_operand_object       *buffer_desc,
-	union acpi_operand_object       *offset_desc,
-	union acpi_operand_object       *length_desc,
-	union acpi_operand_object       *result_desc);
-
-acpi_status
 acpi_ds_eval_buffer_field_operands (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         *op);
@@ -165,12 +149,6 @@
 /* dsfield - Parser/Interpreter interface for AML fields */
 
 acpi_status
-acpi_ds_get_field_names (
-	struct acpi_create_field_info   *info,
-	struct acpi_walk_state          *walk_state,
-	union acpi_parse_object         *arg);
-
-acpi_status
 acpi_ds_create_field (
 	union acpi_parse_object         *op,
 	struct acpi_namespace_node      *region_node,
@@ -202,15 +180,6 @@
 /* dsload - Parser/Interpreter interface, namespace load callbacks */
 
 acpi_status
-acpi_ds_load1_begin_op (
-	struct acpi_walk_state          *walk_state,
-	union acpi_parse_object         **out_op);
-
-acpi_status
-acpi_ds_load1_end_op (
-	struct acpi_walk_state          *walk_state);
-
-acpi_status
 acpi_ds_load2_begin_op (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         **out_op);
@@ -265,12 +234,6 @@
 	struct acpi_walk_state          *walk_state,
 	union acpi_operand_object       **dest_desc);
 
-void
-acpi_ds_method_data_delete_value (
-	u16                             opcode,
-	u32                             index,
-	struct acpi_walk_state          *walk_state);
-
 acpi_status
 acpi_ds_method_data_init_args (
 	union acpi_operand_object       **params,
@@ -288,13 +251,6 @@
 acpi_ds_method_data_init (
 	struct acpi_walk_state          *walk_state);
 
-acpi_status
-acpi_ds_method_data_set_value (
-	u16                             opcode,
-	u32                             index,
-	union acpi_operand_object       *object,
-	struct acpi_walk_state          *walk_state);
-
 
 /* dsmethod - Parser/Interpreter interface - control method parsing */
 
@@ -327,13 +283,6 @@
 /* dsobj - Parser/Interpreter interface - object initialization and conversion */
 
 acpi_status
-acpi_ds_init_one_object (
-	acpi_handle                     obj_handle,
-	u32                             level,
-	void                            *context,
-	void                            **return_value);
-
-acpi_status
 acpi_ds_initialize_objects (
 	struct acpi_table_desc          *table_desc,
 	struct acpi_namespace_node      *start_node);
@@ -353,12 +302,6 @@
 	union acpi_operand_object       **obj_desc);
 
 acpi_status
-acpi_ds_build_internal_object (
-	struct acpi_walk_state          *walk_state,
-	union acpi_parse_object         *op,
-	union acpi_operand_object       **obj_desc_ptr);
-
-acpi_status
 acpi_ds_init_object_from_op (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         *op,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsfield.c.old	2005-01-26 20:00:25.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsfield.c	2005-01-26 20:00:35.000000000 +0100
@@ -205,7 +205,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_get_field_names (
 	struct acpi_create_field_info   *info,
 	struct acpi_walk_state          *walk_state,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsinit.c.old	2005-01-26 20:01:04.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsinit.c	2005-01-26 20:01:13.000000000 +0100
@@ -70,7 +70,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_init_one_object (
 	acpi_handle                     obj_handle,
 	u32                             level,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsmthdat.c.old	2005-01-26 20:01:39.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsmthdat.c	2005-01-26 22:37:13.000000000 +0100
@@ -52,6 +52,12 @@
 #define _COMPONENT          ACPI_DISPATCHER
 	 ACPI_MODULE_NAME    ("dsmthdat")
 
+static acpi_status
+acpi_ds_method_data_set_value (
+	u16                             opcode,
+	u32                             index,
+	union acpi_operand_object       *object,
+	struct acpi_walk_state          *walk_state);
 
 /*******************************************************************************
  *
@@ -297,7 +303,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_method_data_set_value (
 	u16                             opcode,
 	u32                             index,
@@ -511,7 +517,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ds_method_data_delete_value (
 	u16                             opcode,
 	u32                             index,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsobject.c.old	2005-01-26 20:02:33.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsobject.c	2005-01-26 20:02:39.000000000 +0100
@@ -69,7 +69,7 @@
  *
  ****************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_build_internal_object (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         *op,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsopcode.c.old	2005-01-26 20:03:04.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dsopcode.c	2005-01-26 20:03:30.000000000 +0100
@@ -69,7 +69,7 @@
  *
  ****************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_execute_arguments (
 	struct acpi_namespace_node      *node,
 	struct acpi_namespace_node      *scope_node,
@@ -399,7 +399,7 @@
  *
  ****************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_init_buffer_field (
 	u16                             aml_opcode,
 	union acpi_operand_object       *obj_desc,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dswload.c.old	2005-01-26 20:04:01.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/dispatcher/dswload.c	2005-01-26 20:05:39.000000000 +0100
@@ -57,6 +57,14 @@
 #define _COMPONENT          ACPI_DISPATCHER
 	 ACPI_MODULE_NAME    ("dswload")
 
+static acpi_status
+acpi_ds_load1_begin_op (
+	struct acpi_walk_state          *walk_state,
+	union acpi_parse_object         **out_op);
+
+static acpi_status
+acpi_ds_load1_end_op (
+	struct acpi_walk_state          *walk_state);
 
 /*******************************************************************************
  *
@@ -120,7 +128,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_load1_begin_op (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         **out_op)
@@ -345,7 +353,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ds_load1_end_op (
 	struct acpi_walk_state          *walk_state)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/ec.c.old	2005-01-26 20:05:54.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/ec.c	2005-01-26 20:06:06.000000000 +0100
@@ -514,7 +514,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ec_dir;
+static struct proc_dir_entry	*acpi_ec_dir;
 
 
 static int
--- linux-2.6.11-rc2-mm1-full/include/acpi/acevents.h.old	2005-01-26 20:06:26.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acevents.h	2005-01-26 20:14:57.000000000 +0100
@@ -58,18 +58,10 @@
  * Evfixed - Fixed event handling
  */
 
-acpi_status
-acpi_ev_fixed_event_initialize (
-	void);
-
 u32
 acpi_ev_fixed_event_detect (
 	void);
 
-u32
-acpi_ev_fixed_event_dispatch (
-	u32                             event);
-
 
 /*
  * Evmisc
@@ -160,11 +152,6 @@
 	struct acpi_gpe_block_info      *gpe_block);
 
 u32
-acpi_ev_gpe_dispatch (
-	struct acpi_gpe_event_info      *gpe_event_info,
-	u32                             gpe_number);
-
-u32
 acpi_ev_gpe_detect (
 	struct acpi_gpe_xrupt_info      *gpe_xrupt_list);
 
@@ -198,13 +185,6 @@
 	void                            *value);
 
 acpi_status
-acpi_ev_install_handler (
-	acpi_handle                     obj_handle,
-	u32                             level,
-	void                            *context,
-	void                            **return_value);
-
-acpi_status
 acpi_ev_attach_region (
 	union acpi_operand_object       *handler_obj,
 	union acpi_operand_object       *region_obj,
@@ -233,13 +213,6 @@
 	union acpi_operand_object      *region_obj,
 	u32                             function);
 
-acpi_status
-acpi_ev_reg_run (
-	acpi_handle                     obj_handle,
-	u32                             level,
-	void                            *context,
-	void                            **return_value);
-
 /*
  * Evregini - Region initialization and setup
  */
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/events/evevent.c.old	2005-01-26 20:06:42.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/events/evevent.c	2005-01-26 20:07:44.000000000 +0100
@@ -47,6 +47,13 @@
 #define _COMPONENT          ACPI_EVENTS
 	 ACPI_MODULE_NAME    ("evevent")
 
+static u32
+acpi_ev_fixed_event_dispatch (
+	u32                             event);
+
+static acpi_status
+acpi_ev_fixed_event_initialize (
+	void);
 
 /*******************************************************************************
  *
@@ -161,7 +168,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ev_fixed_event_initialize (
 	void)
 {
@@ -259,7 +266,7 @@
  *
  ******************************************************************************/
 
-u32
+static u32
 acpi_ev_fixed_event_dispatch (
 	u32                             event)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/events/evgpe.c.old	2005-01-26 20:08:09.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/events/evgpe.c	2005-01-26 20:08:39.000000000 +0100
@@ -48,6 +48,10 @@
 #define _COMPONENT          ACPI_EVENTS
 	 ACPI_MODULE_NAME    ("evgpe")
 
+static u32
+acpi_ev_gpe_dispatch (
+	struct acpi_gpe_event_info      *gpe_event_info,
+	u32                             gpe_number);
 
 /*******************************************************************************
  *
@@ -587,7 +591,7 @@
  *
  ******************************************************************************/
 
-u32
+static u32
 acpi_ev_gpe_dispatch (
 	struct acpi_gpe_event_info      *gpe_event_info,
 	u32                             gpe_number)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/events/evregion.c.old	2005-01-26 20:14:38.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/events/evregion.c	2005-01-26 20:15:25.000000000 +0100
@@ -52,6 +52,13 @@
 
 #define ACPI_NUM_DEFAULT_SPACES     4
 
+static acpi_status
+acpi_ev_reg_run (
+	acpi_handle                     obj_handle,
+	u32                             level,
+	void                            *context,
+	void                            **return_value);
+
 static u8                   acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
 			 ACPI_ADR_SPACE_SYSTEM_MEMORY,
 			 ACPI_ADR_SPACE_SYSTEM_IO,
@@ -621,7 +628,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ev_install_handler (
 	acpi_handle                     obj_handle,
 	u32                             level,
@@ -1011,7 +1018,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ev_reg_run (
 	acpi_handle                     obj_handle,
 	u32                             level,
--- linux-2.6.11-rc2-mm1-full/include/acpi/acinterp.h.old	2005-01-26 21:30:15.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acinterp.h	2005-01-26 21:38:37.000000000 +0100
@@ -54,12 +54,6 @@
 	union acpi_operand_object       **stack_ptr,
 	struct acpi_walk_state          *walk_state);
 
-acpi_status
-acpi_ex_check_object_type (
-	acpi_object_type                type_needed,
-	acpi_object_type                this_type,
-	void                            *object);
-
 /*
  * exxface - External interpreter interfaces
  */
@@ -110,12 +104,6 @@
 	union acpi_operand_object       **result_desc,
 	struct acpi_walk_state          *walk_state);
 
-u32
-acpi_ex_convert_to_ascii (
-	acpi_integer                    integer,
-	u16                             base,
-	u8                              *string,
-	u8                              max_length);
 
 /*
  * exfield - ACPI AML (p-code) execution - field manipulation
@@ -140,36 +128,12 @@
 	u32                             buffer_length);
 
 acpi_status
-acpi_ex_setup_region (
-	union acpi_operand_object       *obj_desc,
-	u32                             field_datum_byte_offset);
-
-acpi_status
 acpi_ex_access_region (
 	union acpi_operand_object       *obj_desc,
 	u32                             field_datum_byte_offset,
 	acpi_integer                    *value,
 	u32                             read_write);
 
-u8
-acpi_ex_register_overflow (
-	union acpi_operand_object       *obj_desc,
-	acpi_integer                    value);
-
-acpi_status
-acpi_ex_field_datum_io (
-	union acpi_operand_object       *obj_desc,
-	u32                             field_datum_byte_offset,
-	acpi_integer                    *value,
-	u32                             read_write);
-
-acpi_status
-acpi_ex_write_with_update_rule (
-	union acpi_operand_object       *obj_desc,
-	acpi_integer                    mask,
-	acpi_integer                    field_value,
-	u32                             field_datum_byte_offset);
-
 void
 acpi_ex_get_buffer_datum(
 	acpi_integer                    *datum,
@@ -214,12 +178,6 @@
 acpi_ex_opcode_6A_0T_1R (
 	struct acpi_walk_state          *walk_state);
 
-u8
-acpi_ex_do_match (
-	u32                             match_op,
-	acpi_integer                    package_value,
-	acpi_integer                    match_value);
-
 acpi_status
 acpi_ex_get_object_reference (
 	union acpi_operand_object       *obj_desc,
@@ -310,12 +268,6 @@
  */
 
 acpi_status
-acpi_ex_add_table (
-	struct acpi_table_header        *table,
-	struct acpi_namespace_node      *parent_node,
-	union acpi_operand_object       **ddb_handle);
-
-acpi_status
 acpi_ex_load_op (
 	union acpi_operand_object       *obj_desc,
 	union acpi_operand_object       *target,
@@ -354,11 +306,6 @@
 acpi_ex_unlink_mutex (
 	union acpi_operand_object       *obj_desc);
 
-void
-acpi_ex_link_mutex (
-	union acpi_operand_object       *obj_desc,
-	struct acpi_thread_state        *thread);
-
 /*
  * exprep - ACPI AML (p-code) execution - prep utilities
  */
@@ -479,11 +426,6 @@
 	struct acpi_namespace_node      **stack_ptr,
 	struct acpi_walk_state          *walk_state);
 
-acpi_status
-acpi_ex_resolve_object_to_value (
-	union acpi_operand_object       **stack_ptr,
-	struct acpi_walk_state          *walk_state);
-
 
 /*
  * exdump - Interpreter debug output routines
@@ -540,21 +482,11 @@
  * exnames - interpreter/scanner name load/execute
  */
 
-char *
-acpi_ex_allocate_name_string (
-	u32                             prefix_count,
-	u32                             num_name_segs);
-
 u32
 acpi_ex_good_char (
 	u32                             character);
 
 acpi_status
-acpi_ex_name_segment (
-	u8                              **in_aml_address,
-	char                            *name_string);
-
-acpi_status
 acpi_ex_get_name_string (
 	acpi_object_type                data_type,
 	u8                              *in_aml_address,
@@ -578,12 +510,6 @@
 	struct acpi_walk_state          *walk_state);
 
 acpi_status
-acpi_ex_store_object_to_index (
-	union acpi_operand_object       *val_desc,
-	union acpi_operand_object       *dest_desc,
-	struct acpi_walk_state          *walk_state);
-
-acpi_status
 acpi_ex_store_object_to_node (
 	union acpi_operand_object       *source_desc,
 	struct acpi_namespace_node      *node,
@@ -669,11 +595,6 @@
 acpi_ex_release_global_lock (
 	u8                              locked);
 
-u32
-acpi_ex_digits_needed (
-	acpi_integer                    value,
-	u32                             base);
-
 void
 acpi_ex_eisa_id_to_string (
 	u32                             numeric_id,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exconfig.c.old	2005-01-26 21:30:35.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exconfig.c	2005-01-26 21:30:40.000000000 +0100
@@ -70,7 +70,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_add_table (
 	struct acpi_table_header        *table,
 	struct acpi_namespace_node      *parent_node,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exconvrt.c.old	2005-01-26 21:31:39.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exconvrt.c	2005-01-26 21:31:44.000000000 +0100
@@ -285,7 +285,7 @@
  *
  ******************************************************************************/
 
-u32
+static u32
 acpi_ex_convert_to_ascii (
 	acpi_integer                    integer,
 	u16                             base,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exfldio.c.old	2005-01-26 21:32:10.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exfldio.c	2005-01-26 21:33:22.000000000 +0100
@@ -69,7 +69,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_setup_region (
 	union acpi_operand_object       *obj_desc,
 	u32                             field_datum_byte_offset)
@@ -287,7 +287,7 @@
  *
  ******************************************************************************/
 
-u8
+static u8
 acpi_ex_register_overflow (
 	union acpi_operand_object       *obj_desc,
 	acpi_integer                    value)
@@ -333,7 +333,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_field_datum_io (
 	union acpi_operand_object       *obj_desc,
 	u32                             field_datum_byte_offset,
@@ -524,7 +524,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_write_with_update_rule (
 	union acpi_operand_object       *obj_desc,
 	acpi_integer                    mask,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exmutex.c.old	2005-01-26 21:34:40.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exmutex.c	2005-01-26 21:33:50.000000000 +0100
@@ -101,7 +101,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ex_link_mutex (
 	union acpi_operand_object       *obj_desc,
 	struct acpi_thread_state        *thread)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exnames.c.old	2005-01-26 21:34:59.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exnames.c	2005-01-26 21:35:27.000000000 +0100
@@ -75,7 +75,7 @@
  *
  ******************************************************************************/
 
-char *
+static char *
 acpi_ex_allocate_name_string (
 	u32                             prefix_count,
 	u32                             num_name_segs)
@@ -160,7 +160,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_name_segment (
 	u8                              **in_aml_address,
 	char                            *name_string)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exoparg6.c.old	2005-01-26 21:35:51.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exoparg6.c	2005-01-26 21:35:56.000000000 +0100
@@ -90,7 +90,7 @@
  *
  ******************************************************************************/
 
-u8
+static u8
 acpi_ex_do_match (
 	u32                             match_op,
 	acpi_integer                    package_value,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exresolv.c.old	2005-01-26 21:36:29.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exresolv.c	2005-01-26 21:37:11.000000000 +0100
@@ -54,6 +54,10 @@
 #define _COMPONENT          ACPI_EXECUTER
 	 ACPI_MODULE_NAME    ("exresolv")
 
+static acpi_status
+acpi_ex_resolve_object_to_value (
+	union acpi_operand_object       **stack_ptr,
+	struct acpi_walk_state          *walk_state);
 
 /*******************************************************************************
  *
@@ -131,7 +135,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_resolve_object_to_value (
 	union acpi_operand_object       **stack_ptr,
 	struct acpi_walk_state          *walk_state)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exresop.c.old	2005-01-26 21:37:34.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exresop.c	2005-01-26 21:37:38.000000000 +0100
@@ -67,7 +67,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_check_object_type (
 	acpi_object_type                type_needed,
 	acpi_object_type                this_type,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exstore.c.old	2005-01-26 21:38:00.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exstore.c	2005-01-26 21:38:22.000000000 +0100
@@ -53,6 +53,11 @@
 #define _COMPONENT          ACPI_EXECUTER
 	 ACPI_MODULE_NAME    ("exstore")
 
+static acpi_status
+acpi_ex_store_object_to_index (
+	union acpi_operand_object       *source_desc,
+	union acpi_operand_object       *index_desc,
+	struct acpi_walk_state          *walk_state);
 
 /*******************************************************************************
  *
@@ -272,7 +277,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ex_store_object_to_index (
 	union acpi_operand_object       *source_desc,
 	union acpi_operand_object       *index_desc,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exutils.c.old	2005-01-26 21:38:46.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/executer/exutils.c	2005-01-26 21:38:56.000000000 +0100
@@ -273,7 +273,7 @@
  *
  ******************************************************************************/
 
-u32
+static u32
 acpi_ex_digits_needed (
 	acpi_integer                    value,
 	u32                             base)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/fan.c.old	2005-01-26 21:39:11.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/fan.c	2005-01-26 21:40:22.000000000 +0100
@@ -50,8 +50,8 @@
 MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-int acpi_fan_add (struct acpi_device *device);
-int acpi_fan_remove (struct acpi_device *device, int type);
+static int acpi_fan_add (struct acpi_device *device);
+static int acpi_fan_remove (struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_fan_driver = {
 	.name =		ACPI_FAN_DRIVER_NAME,
@@ -72,7 +72,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_fan_dir;
+static struct proc_dir_entry	*acpi_fan_dir;
 
 
 static int
@@ -194,7 +194,7 @@
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_fan_add (
 	struct acpi_device	*device)
 {
@@ -240,7 +240,7 @@
 }
 
 
-int
+static int
 acpi_fan_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -262,7 +262,7 @@
 }
 
 
-int __init
+static int __init
 acpi_fan_init (void)
 {
 	int			result = 0;
@@ -284,7 +284,7 @@
 }
 
 
-void __exit
+static void __exit
 acpi_fan_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_fan_exit");
--- linux-2.6.11-rc2-mm1-full/include/acpi/achware.h.old	2005-01-26 21:40:42.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/achware.h	2005-01-26 21:40:51.000000000 +0100
@@ -155,11 +155,6 @@
 	struct acpi_gpe_xrupt_info      *gpe_xrupt_info,
 	struct acpi_gpe_block_info      *gpe_block);
 
-acpi_status
-acpi_hw_enable_wakeup_gpe_block (
-	struct acpi_gpe_xrupt_info      *gpe_xrupt_info,
-	struct acpi_gpe_block_info      *gpe_block);
-
 
 /* ACPI Timer prototypes */
 
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/hardware/hwgpe.c.old	2005-01-26 21:40:57.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/hardware/hwgpe.c	2005-01-26 21:41:06.000000000 +0100
@@ -332,7 +332,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_hw_enable_wakeup_gpe_block (
 	struct acpi_gpe_xrupt_info      *gpe_xrupt_info,
 	struct acpi_gpe_block_info      *gpe_block)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/ibm_acpi.c.old	2005-01-26 21:41:22.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/ibm_acpi.c	2005-01-26 21:42:24.000000000 +0100
@@ -155,7 +155,7 @@
 	int experimental;
 };
 
-struct proc_dir_entry *proc_dir = NULL;
+static struct proc_dir_entry *proc_dir = NULL;
 
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -856,7 +856,7 @@
 	return 0;
 }	
 		
-struct ibm_struct ibms[] = {
+static struct ibm_struct ibms[] = {
 	{
 		.name	= "driver",
 		.init	= driver_init,
--- linux-2.6.11-rc2-mm1-full/include/acpi/acnamesp.h.old	2005-01-26 21:50:46.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acnamesp.h	2005-01-26 21:58:49.000000000 +0100
@@ -96,21 +96,6 @@
 /* Namespace init - nsxfinit */
 
 acpi_status
-acpi_ns_init_one_device (
-	acpi_handle                     obj_handle,
-	u32                             nesting_level,
-	void                            *context,
-	void                            **return_value);
-
-acpi_status
-acpi_ns_init_one_object (
-	acpi_handle                     obj_handle,
-	u32                             level,
-	void                            *context,
-	void                            **return_value);
-
-
-acpi_status
 acpi_ns_walk_namespace (
 	acpi_object_type                type,
 	acpi_handle                     start_object,
@@ -134,11 +119,6 @@
 /* Namespace loading - nsload */
 
 acpi_status
-acpi_ns_one_complete_parse (
-	u32                             pass_number,
-	struct acpi_table_desc          *table_desc);
-
-acpi_status
 acpi_ns_parse_table (
 	struct acpi_table_desc          *table_desc,
 	struct acpi_namespace_node      *scope);
@@ -148,10 +128,6 @@
 	struct acpi_table_desc          *table_desc,
 	struct acpi_namespace_node      *node);
 
-acpi_status
-acpi_ns_load_table_by_type (
-	acpi_table_type                 table_type);
-
 
 /*
  * Top-level namespace access - nsaccess
@@ -201,10 +177,6 @@
 	char                            *name1,
 	char                            *name2);
 
-void
-acpi_ns_remove_reference (
-	struct acpi_namespace_node      *node);
-
 
 /*
  * Namespace modification - nsmodify
@@ -298,14 +270,6 @@
 	char                            *pathname,
 	struct acpi_parameter_info      *info);
 
-acpi_status
-acpi_ns_execute_control_method (
-	struct acpi_parameter_info      *info);
-
-acpi_status
-acpi_ns_get_object_value (
-	struct acpi_parameter_info      *info);
-
 
 /*
  * Parent/Child/Peer utility functions
@@ -326,12 +290,6 @@
 acpi_ns_opens_scope (
 	acpi_object_type                type);
 
-void
-acpi_ns_build_external_path (
-	struct acpi_namespace_node      *node,
-	acpi_size                       size,
-	char                            *name_buffer);
-
 char *
 acpi_ns_get_external_pathname (
 	struct acpi_namespace_node      *node);
@@ -435,10 +393,6 @@
 acpi_ns_valid_root_prefix (
 	char                            prefix);
 
-u8
-acpi_ns_valid_path_separator (
-	char                            sep);
-
 acpi_object_type
 acpi_ns_get_type (
 	struct acpi_namespace_node      *node);
@@ -471,25 +425,10 @@
 	char                            *msg);
 
 acpi_status
-acpi_ns_build_internal_name (
-	struct acpi_namestring_info     *info);
-
-void
-acpi_ns_get_internal_name_length (
-	struct acpi_namestring_info     *info);
-
-acpi_status
 acpi_ns_internalize_name (
 	char                            *dotted_name,
 	char                            **converted_name);
 
-acpi_status
-acpi_ns_externalize_name (
-	u32                             internal_name_length,
-	char                            *internal_name,
-	u32                             *converted_name_length,
-	char                            **converted_name);
-
 struct acpi_namespace_node *
 acpi_ns_map_handle_to_node (
 	acpi_handle                     handle);
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsalloc.c.old	2005-01-26 21:51:03.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsalloc.c	2005-01-26 21:51:08.000000000 +0100
@@ -548,7 +548,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ns_remove_reference (
 	struct acpi_namespace_node      *node)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nseval.c.old	2005-01-26 21:51:47.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nseval.c	2005-01-26 21:53:09.000000000 +0100
@@ -52,6 +52,13 @@
 #define _COMPONENT          ACPI_NAMESPACE
 	 ACPI_MODULE_NAME    ("nseval")
 
+static acpi_status
+acpi_ns_execute_control_method (
+	struct acpi_parameter_info      *info);
+
+static acpi_status
+acpi_ns_get_object_value (
+	struct acpi_parameter_info      *info);
 
 /*******************************************************************************
  *
@@ -355,7 +362,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_execute_control_method (
 	struct acpi_parameter_info      *info)
 {
@@ -424,7 +431,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_get_object_value (
 	struct acpi_parameter_info      *info)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsinit.c.old	2005-01-26 21:53:51.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsinit.c	2005-01-26 21:54:38.000000000 +0100
@@ -50,6 +50,19 @@
 #define _COMPONENT          ACPI_NAMESPACE
 	 ACPI_MODULE_NAME    ("nsinit")
 
+static acpi_status
+acpi_ns_init_one_device (
+	acpi_handle                     obj_handle,
+	u32                             nesting_level,
+	void                            *context,
+	void                            **return_value);
+
+static acpi_status
+acpi_ns_init_one_object (
+	acpi_handle                     obj_handle,
+	u32                             level,
+	void                            *context,
+	void                            **return_value);
 
 /*******************************************************************************
  *
@@ -191,7 +204,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_init_one_object (
 	acpi_handle                     obj_handle,
 	u32                             level,
@@ -331,7 +344,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_init_one_device (
 	acpi_handle                     obj_handle,
 	u32                             nesting_level,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsload.c.old	2005-01-26 21:55:08.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsload.c	2005-01-26 21:55:13.000000000 +0100
@@ -159,7 +159,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_load_table_by_type (
 	acpi_table_type                 table_type)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsnames.c.old	2005-01-26 21:56:31.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsnames.c	2005-01-26 21:56:36.000000000 +0100
@@ -66,7 +66,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ns_build_external_path (
 	struct acpi_namespace_node      *node,
 	acpi_size                       size,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsparse.c.old	2005-01-26 21:56:57.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsparse.c	2005-01-26 21:57:03.000000000 +0100
@@ -65,7 +65,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_one_complete_parse (
 	u32                             pass_number,
 	struct acpi_table_desc          *table_desc)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsutils.c.old	2005-01-26 21:57:29.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/namespace/nsutils.c	2005-01-26 21:59:10.000000000 +0100
@@ -51,6 +51,12 @@
 #define _COMPONENT          ACPI_NAMESPACE
 	 ACPI_MODULE_NAME    ("nsutils")
 
+static acpi_status
+acpi_ns_externalize_name (
+	u32                             internal_name_length,
+	char                            *internal_name,
+	u32                             *converted_name_length,
+	char                            **converted_name);
 
 /*******************************************************************************
  *
@@ -232,7 +238,7 @@
  *
  ******************************************************************************/
 
-u8
+static u8
 acpi_ns_valid_path_separator (
 	char                            sep)
 {
@@ -310,7 +316,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ns_get_internal_name_length (
 	struct acpi_namestring_info     *info)
 {
@@ -381,7 +387,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_build_internal_name (
 	struct acpi_namestring_info     *info)
 {
@@ -562,7 +568,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ns_externalize_name (
 	u32                             internal_name_length,
 	char                            *internal_name,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/osl.c.old	2005-01-26 21:59:25.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/osl.c	2005-01-26 22:00:15.000000000 +0100
@@ -563,7 +563,7 @@
 }
 
 /* TODO: Change code to take advantage of driver model more */
-void
+static void
 acpi_os_derive_pci_id_2 (
 	acpi_handle		rhandle,        /* upper bound  */
 	acpi_handle		chandle,        /* current node */
@@ -1071,7 +1071,7 @@
 }
 EXPORT_SYMBOL(acpi_os_signal);
 
-int __init
+static int __init
 acpi_os_name_setup(char *str)
 {
 	char *p = acpi_os_name;
@@ -1101,7 +1101,7 @@
  * empty string disables _OSI
  * TBD additional string adds to _OSI
  */
-int __init
+static int __init
 acpi_osi_setup(char *str)
 {
 	if (str == NULL || *str == '\0') {
@@ -1119,7 +1119,7 @@
 __setup("acpi_osi=", acpi_osi_setup);
 
 /* enable serialization to combat AE_ALREADY_EXISTS errors */
-int __init
+static int __init
 acpi_serialize_setup(char *str)
 {
 	printk(KERN_INFO PREFIX "serialize enabled\n");
@@ -1140,7 +1140,7 @@
  * Run-time events on the same GPE this flag is available
  * to tell Linux to keep the wake-time GPEs enabled at run-time.
  */
-int __init
+static int __init
 acpi_wake_gpes_always_on_setup(char *str)
 {
 	printk(KERN_INFO PREFIX "wake GPEs not disabled\n");
--- linux-2.6.11-rc2-mm1-full/include/acpi/acparser.h.old	2005-01-26 22:00:30.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acparser.h	2005-01-26 22:06:51.000000000 +0100
@@ -89,10 +89,6 @@
 acpi_ps_get_next_package_end (
 	struct acpi_parse_state         *parser_state);
 
-u32
-acpi_ps_get_next_package_length (
-	struct acpi_parse_state         *parser_state);
-
 char *
 acpi_ps_get_next_namestring (
 	struct acpi_parse_state         *parser_state);
@@ -110,10 +106,6 @@
 	union acpi_parse_object         *arg,
 	u8                              method_call);
 
-union acpi_parse_object *
-acpi_ps_get_next_field (
-	struct acpi_parse_state         *parser_state);
-
 acpi_status
 acpi_ps_get_next_arg (
 	struct acpi_walk_state          *walk_state,
@@ -148,21 +140,6 @@
 
 /* psparse - top level parsing routines */
 
-u32
-acpi_ps_get_opcode_size (
-	u32                             opcode);
-
-void
-acpi_ps_complete_this_op (
-	struct acpi_walk_state          *walk_state,
-	union acpi_parse_object         *op);
-
-acpi_status
-acpi_ps_next_parse_state (
-	struct acpi_walk_state          *walk_state,
-	union acpi_parse_object         *op,
-	acpi_status                     callback_status);
-
 acpi_status
 acpi_ps_find_object (
 	struct acpi_walk_state          *walk_state,
@@ -173,10 +150,6 @@
 	union acpi_parse_object         *root);
 
 acpi_status
-acpi_ps_parse_loop (
-	struct acpi_walk_state          *walk_state);
-
-acpi_status
 acpi_ps_parse_aml (
 	struct acpi_walk_state          *walk_state);
 
@@ -273,16 +246,6 @@
 	acpi_parse_downwards            descending_callback,
 	acpi_parse_upwards              ascending_callback);
 
-acpi_status
-acpi_ps_get_next_walk_op (
-	struct acpi_walk_state          *walk_state,
-	union acpi_parse_object         *op,
-	acpi_parse_upwards              ascending_callback);
-
-acpi_status
-acpi_ps_delete_completed_op (
-	struct acpi_walk_state          *walk_state);
-
 
 /* psutils - parser utilities */
 
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/psargs.c.old	2005-01-26 22:00:55.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/psargs.c	2005-01-26 22:01:24.000000000 +0100
@@ -64,7 +64,7 @@
  *
  ******************************************************************************/
 
-u32
+static u32
 acpi_ps_get_next_package_length (
 	struct acpi_parse_state         *parser_state)
 {
@@ -486,7 +486,7 @@
  *
  ******************************************************************************/
 
-union acpi_parse_object *
+static union acpi_parse_object *
 acpi_ps_get_next_field (
 	struct acpi_parse_state         *parser_state)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/psopcode.c.old	2005-01-26 22:04:20.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/psopcode.c	2005-01-26 22:04:32.000000000 +0100
@@ -468,7 +468,7 @@
  */
 
 
-const struct acpi_opcode_info     acpi_gbl_aml_op_info[AML_NUM_OPCODES] =
+static const struct acpi_opcode_info     acpi_gbl_aml_op_info[AML_NUM_OPCODES] =
 {
 /*! [Begin] no source code translation */
 /* Index           Name                 Parser Args               Interpreter Args                ObjectType                    Class                      Type                  Flags */
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/psparse.c.old	2005-01-26 22:05:12.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/psparse.c	2005-01-26 22:06:05.000000000 +0100
@@ -77,7 +77,7 @@
  *
  ******************************************************************************/
 
-u32
+static u32
 acpi_ps_get_opcode_size (
 	u32                             opcode)
 {
@@ -142,7 +142,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ps_complete_this_op (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         *op)
@@ -300,7 +300,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ps_next_parse_state (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         *op,
@@ -421,7 +421,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ps_parse_loop (
 	struct acpi_walk_state          *walk_state)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/pswalk.c.old	2005-01-26 22:06:29.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/parser/pswalk.c	2005-01-26 22:06:58.000000000 +0100
@@ -64,7 +64,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ps_get_next_walk_op (
 	struct acpi_walk_state          *walk_state,
 	union acpi_parse_object         *op,
@@ -225,7 +225,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ps_delete_completed_op (
 	struct acpi_walk_state          *walk_state)
 {
--- linux-2.6.11-rc2-mm1-full/include/acpi/acpi_drivers.h.old	2005-01-26 22:08:34.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acpi_drivers.h	2005-01-26 22:08:38.000000000 +0100
@@ -68,7 +68,6 @@
 struct pci_bus;
 
 int acpi_pci_bind (struct acpi_device *device);
-int acpi_pci_unbind (struct acpi_device *device);
 int acpi_pci_bind_root (struct acpi_device *device, struct acpi_pci_id *id, struct pci_bus *bus);
 
 /* Arch-defined function to add a bus to the system */
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/pci_bind.c.old	2005-01-26 22:07:20.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/pci_bind.c	2005-01-26 22:08:20.000000000 +0100
@@ -45,8 +45,10 @@
 	struct pci_dev		*dev;
 };
 
+static int acpi_pci_unbind(
+	struct acpi_device      *device);
 
-void
+static void
 acpi_pci_data_handler (
 	acpi_handle		handle,
 	u32			function,
@@ -270,7 +272,7 @@
 	return_VALUE(result);
 }
 
-int acpi_pci_unbind(
+static int acpi_pci_unbind(
 	struct acpi_device      *device)
 {
 	int                     result = 0;
--- linux-2.6.11-rc2-mm1-full/include/linux/acpi.h.old	2005-01-26 22:09:31.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/linux/acpi.h	2005-01-26 22:09:44.000000000 +0100
@@ -455,8 +455,6 @@
 	struct list_head	entries;
 };
 
-extern struct acpi_prt_list	acpi_prt;
-
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/pci_irq.c.old	2005-01-26 22:09:52.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/pci_irq.c	2005-01-26 22:10:10.000000000 +0100
@@ -42,8 +42,8 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME		("pci_irq")
 
-struct acpi_prt_list		acpi_prt;
-DEFINE_SPINLOCK(acpi_prt_lock);
+static struct acpi_prt_list	acpi_prt;
+static DEFINE_SPINLOCK(acpi_prt_lock);
 
 /* --------------------------------------------------------------------------
                          PCI IRQ Routing Table (PRT) Support
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/power.c.old	2005-01-26 22:10:27.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/power.c	2005-01-26 22:11:21.000000000 +0100
@@ -58,8 +58,8 @@
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-int acpi_power_add (struct acpi_device *device);
-int acpi_power_remove (struct acpi_device *device, int type);
+static int acpi_power_add (struct acpi_device *device);
+static int acpi_power_remove (struct acpi_device *device, int type);
 static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_power_driver = {
@@ -479,7 +479,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_power_dir;
+static struct proc_dir_entry	*acpi_power_dir;
 
 static int acpi_power_seq_show(struct seq_file *seq, void *offset)
 {
@@ -576,7 +576,7 @@
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_power_add (
 	struct acpi_device	*device)
 {
@@ -642,7 +642,7 @@
 }
 
 
-int
+static int
 acpi_power_remove (
 	struct acpi_device	*device,
 	int			type)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_core.c.old	2005-01-26 22:11:36.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_core.c	2005-01-26 22:48:14.000000000 +0100
@@ -105,7 +105,7 @@
 #define UNINSTALL_NOTIFY_HANDLER	2
 
 
-struct file_operations acpi_processor_info_fops = {
+static struct file_operations acpi_processor_info_fops = {
 	.open 		= acpi_processor_info_open_fs,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -121,7 +121,7 @@
                                 Errata Handling
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_processor_errata_piix4 (
 	struct pci_dev		*dev)
 {
@@ -259,7 +259,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_processor_dir = NULL;
+static struct proc_dir_entry	*acpi_processor_dir = NULL;
 
 static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
 {
--- linux-2.6.11-rc2-mm1-full/include/acpi/processor.h.old	2005-01-26 22:13:23.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/processor.h	2005-01-26 22:14:00.000000000 +0100
@@ -201,7 +201,6 @@
 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info (struct acpi_processor *pr);
 int acpi_processor_set_throttling (struct acpi_processor *pr, int state);
-int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file);
 ssize_t acpi_processor_write_throttling (
         struct file		*file,
         const char		__user *buffer,
@@ -217,7 +216,6 @@
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info (struct acpi_processor *pr);
-int acpi_processor_limit_open_fs(struct inode *inode, struct file *file);
 ssize_t acpi_processor_write_limit (
 	struct file		*file,
 	const char		__user *buffer,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_thermal.c.old	2005-01-26 22:13:39.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_thermal.c	2005-01-26 22:13:47.000000000 +0100
@@ -345,7 +345,7 @@
 	return_VALUE(0);
 }
 
-int acpi_processor_limit_open_fs(struct inode *inode, struct file *file)
+static int acpi_processor_limit_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_processor_limit_seq_show,
 						PDE(inode)->data);
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_throttling.c.old	2005-01-26 22:14:14.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_throttling.c	2005-01-26 22:14:19.000000000 +0100
@@ -308,7 +308,7 @@
 	return_VALUE(0);
 }
 
-int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file)
+static int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_processor_throttling_seq_show,
 						PDE(inode)->data);
--- linux-2.6.11-rc2-mm1-full/include/acpi/acpi_bus.h.old	2005-01-26 22:15:33.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acpi_bus.h	2005-01-26 22:15:37.000000000 +0100
@@ -328,7 +328,6 @@
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 int acpi_bus_scan (struct acpi_device *start);
-int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_add (struct acpi_device **child, struct acpi_device *parent,
 		acpi_handle handle, int type);
 
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/scan.c.old	2005-01-26 22:14:34.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/scan.c	2005-01-26 22:16:02.000000000 +0100
@@ -27,6 +27,10 @@
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
+static int
+acpi_bus_trim(struct acpi_device	*start,
+		int rmdevice);
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -849,7 +853,7 @@
 	acpi_os_free(buffer.pointer);
 }
 
-int acpi_device_set_context(struct acpi_device * device, int type)
+static int acpi_device_set_context(struct acpi_device * device, int type)
 {
 	acpi_status status = AE_OK;
 	int result = 0;
@@ -874,7 +878,7 @@
 	return result;
 }
 
-void acpi_device_get_debug_info(struct acpi_device * device, acpi_handle handle, int type)
+static void acpi_device_get_debug_info(struct acpi_device * device, acpi_handle handle, int type)
 {
 #ifdef CONFIG_ACPI_DEBUG_OUTPUT
 	char		*type_string = NULL;
@@ -917,7 +921,7 @@
 }
 
 
-int
+static int
 acpi_bus_remove (
 	struct acpi_device *dev,
 	int rmdevice)
@@ -1215,7 +1219,7 @@
 EXPORT_SYMBOL(acpi_bus_scan);
 
 
-int
+static int
 acpi_bus_trim(struct acpi_device	*start,
 		int rmdevice)
 {
--- linux-2.6.11-rc2-mm1-full/include/acpi/actables.h.old	2005-01-26 22:17:40.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/actables.h	2005-01-26 22:22:20.000000000 +0100
@@ -99,17 +99,6 @@
 	struct acpi_table_desc          *table_info);
 
 acpi_status
-acpi_tb_get_this_table (
-	struct acpi_pointer             *address,
-	struct acpi_table_header        *header,
-	struct acpi_table_desc          *table_info);
-
-acpi_status
-acpi_tb_table_override (
-	struct acpi_table_header        *header,
-	struct acpi_table_desc          *table_info);
-
-acpi_status
 acpi_tb_get_table_ptr (
 	acpi_table_type                 table_type,
 	u32                             instance,
@@ -131,17 +120,6 @@
 acpi_tb_get_required_tables (
 	void);
 
-acpi_status
-acpi_tb_get_primary_table (
-	struct acpi_pointer             *address,
-	struct acpi_table_desc          *table_info);
-
-acpi_status
-acpi_tb_get_secondary_table (
-	struct acpi_pointer             *address,
-	acpi_string                     signature,
-	struct acpi_table_desc          *table_info);
-
 /*
  * tbinstall - Table installation
  */
@@ -196,16 +174,6 @@
 acpi_tb_get_table_rsdt (
 	void);
 
-u8 *
-acpi_tb_scan_memory_for_rsdp (
-	u8                              *start_address,
-	u32                             length);
-
-acpi_status
-acpi_tb_find_rsdp (
-	struct acpi_table_desc          *table_info,
-	u32                             flags);
-
 
 /*
  * tbutils - common table utilities
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/tables/tbget.c.old	2005-01-26 22:18:00.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/tables/tbget.c	2005-01-26 22:18:58.000000000 +0100
@@ -49,6 +49,16 @@
 #define _COMPONENT          ACPI_TABLES
 	 ACPI_MODULE_NAME    ("tbget")
 
+static acpi_status
+acpi_tb_get_this_table (
+	struct acpi_pointer             *address,
+	struct acpi_table_header        *header,
+	struct acpi_table_desc          *table_info);
+
+static acpi_status
+acpi_tb_table_override (
+	struct acpi_table_header        *header,
+	struct acpi_table_desc          *table_info);
 
 /*******************************************************************************
  *
@@ -241,7 +251,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_tb_table_override (
 	struct acpi_table_header        *header,
 	struct acpi_table_desc          *table_info)
@@ -315,7 +325,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_tb_get_this_table (
 	struct acpi_pointer             *address,
 	struct acpi_table_header        *header,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/tables/tbgetall.c.old	2005-01-26 22:19:35.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/tables/tbgetall.c	2005-01-26 22:19:54.000000000 +0100
@@ -63,7 +63,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_tb_get_primary_table (
 	struct acpi_pointer             *address,
 	struct acpi_table_desc          *table_info)
@@ -130,7 +130,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_tb_get_secondary_table (
 	struct acpi_pointer             *address,
 	acpi_string                     signature,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/tables/tbxfroot.c.old	2005-01-26 22:21:37.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/tables/tbxfroot.c	2005-01-26 22:22:26.000000000 +0100
@@ -50,6 +50,10 @@
 #define _COMPONENT          ACPI_TABLES
 	 ACPI_MODULE_NAME    ("tbxfroot")
 
+static acpi_status
+acpi_tb_find_rsdp (
+	struct acpi_table_desc          *table_info,
+	u32                             flags);
 
 /*******************************************************************************
  *
@@ -385,7 +389,7 @@
  *
  ******************************************************************************/
 
-u8 *
+static u8 *
 acpi_tb_scan_memory_for_rsdp (
 	u8                              *start_address,
 	u32                             length)
@@ -468,7 +472,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_tb_find_rsdp (
 	struct acpi_table_desc          *table_info,
 	u32                             flags)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/thermal.c.old	2005-01-26 22:22:43.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/thermal.c	2005-01-26 22:22:54.000000000 +0100
@@ -774,7 +774,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_thermal_dir;
+static struct proc_dir_entry	*acpi_thermal_dir;
 
 static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/toshiba_acpi.c.old	2005-01-26 22:23:11.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/toshiba_acpi.c	2005-01-26 22:23:18.000000000 +0100
@@ -481,7 +481,7 @@
 
 #define PROC_TOSHIBA		"toshiba"
 
-ProcItem proc_items[] =
+static ProcItem proc_items[] =
 {
 	{ "lcd"		, read_lcd	, write_lcd	},
 	{ "video"	, read_video	, write_video	},
--- linux-2.6.11-rc2-mm1-full/include/acpi/acutils.h.old	2005-01-26 22:25:01.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acutils.h	2005-01-26 22:43:14.000000000 +0100
@@ -85,10 +85,6 @@
 acpi_ut_init_globals (
 	void);
 
-void
-acpi_ut_terminate (
-	void);
-
 
 /*
  * ut_init - miscellaneous initialization and shutdown
@@ -278,30 +274,11 @@
 	u32                             *space_used);
 
 acpi_status
-acpi_ut_copy_ielement_to_eelement (
-	u8                              object_type,
-	union acpi_operand_object       *source_object,
-	union acpi_generic_state        *state,
-	void                            *context);
-
-acpi_status
-acpi_ut_copy_ielement_to_ielement (
-	u8                              object_type,
-	union acpi_operand_object       *source_object,
-	union acpi_generic_state        *state,
-	void                            *context);
-
-acpi_status
 acpi_ut_copy_iobject_to_eobject (
 	union acpi_operand_object       *obj,
 	struct acpi_buffer              *ret_buffer);
 
 acpi_status
-acpi_ut_copy_esimple_to_isimple(
-	union acpi_object               *user_obj,
-	union acpi_operand_object       **return_obj);
-
-acpi_status
 acpi_ut_copy_eobject_to_iobject (
 	union acpi_object               *obj,
 	union acpi_operand_object       **internal_obj);
@@ -312,17 +289,6 @@
 	union acpi_operand_object       *dest_obj);
 
 acpi_status
-acpi_ut_copy_ipackage_to_ipackage (
-	union acpi_operand_object       *source_obj,
-	union acpi_operand_object       *dest_obj,
-	struct acpi_walk_state          *walk_state);
-
-acpi_status
-acpi_ut_copy_simple_object (
-	union acpi_operand_object       *source_desc,
-	union acpi_operand_object       *dest_desc);
-
-acpi_status
 acpi_ut_copy_iobject_to_iobject (
 	union acpi_operand_object       *source_desc,
 	union acpi_operand_object       **dest_desc,
@@ -444,10 +410,6 @@
  */
 
 void
-acpi_ut_delete_internal_obj (
-	union acpi_operand_object       *object);
-
-void
 acpi_ut_delete_internal_package_object (
 	union acpi_operand_object       *object);
 
@@ -535,14 +497,6 @@
 	void);
 
 acpi_status
-acpi_ut_create_mutex (
-	acpi_mutex_handle               mutex_id);
-
-acpi_status
-acpi_ut_delete_mutex (
-	acpi_mutex_handle               mutex_id);
-
-acpi_status
 acpi_ut_acquire_mutex (
 	acpi_mutex_handle               mutex_id);
 
@@ -605,27 +559,10 @@
  */
 
 acpi_status
-acpi_ut_get_simple_object_size (
-	union acpi_operand_object       *obj,
-	acpi_size                       *obj_length);
-
-acpi_status
-acpi_ut_get_package_object_size (
-	union acpi_operand_object       *obj,
-	acpi_size                       *obj_length);
-
-acpi_status
 acpi_ut_get_object_size(
 	union acpi_operand_object       *obj,
 	acpi_size                       *obj_length);
 
-acpi_status
-acpi_ut_get_element_length (
-	u8                              object_type,
-	union acpi_operand_object       *source_object,
-	union acpi_generic_state        *state,
-	void                            *context);
-
 
 /*
  * ut_state - Generic state creation/cache routines
@@ -654,12 +591,6 @@
 	union acpi_operand_object       *object,
 	u16                             action);
 
-union acpi_generic_state *
-acpi_ut_create_pkg_state (
-	void                            *internal_object,
-	void                            *external_object,
-	u16                             index);
-
 acpi_status
 acpi_ut_create_update_state_and_push (
 	union acpi_operand_object       *object,
@@ -832,29 +763,6 @@
 	char                            *module,
 	u32                             line);
 
-struct acpi_debug_mem_block *
-acpi_ut_find_allocation (
-	u32                             list_id,
-	void                            *allocation);
-
-acpi_status
-acpi_ut_track_allocation (
-	u32                             list_id,
-	struct acpi_debug_mem_block     *address,
-	acpi_size                       size,
-	u8                              alloc_type,
-	u32                             component,
-	char                            *module,
-	u32                             line);
-
-acpi_status
-acpi_ut_remove_allocation (
-	u32                             list_id,
-	struct acpi_debug_mem_block     *address,
-	u32                             component,
-	char                            *module,
-	u32                             line);
-
 #ifdef ACPI_FUTURE_USAGE
 void
 acpi_ut_dump_allocation_info (
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utalloc.c.old	2005-01-26 22:25:20.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utalloc.c	2005-01-26 22:26:59.000000000 +0100
@@ -47,6 +47,23 @@
 #define _COMPONENT          ACPI_UTILITIES
 	 ACPI_MODULE_NAME    ("utalloc")
 
+static acpi_status
+acpi_ut_remove_allocation (
+	u32                             list_id,
+	struct acpi_debug_mem_block     *allocation,
+	u32                             component,
+	char                            *module,
+	u32                             line);
+
+static acpi_status
+acpi_ut_track_allocation (
+	u32                             list_id,
+	struct acpi_debug_mem_block     *allocation,
+	acpi_size                       size,
+	u8                              alloc_type,
+	u32                             component,
+	char                            *module,
+	u32                             line);
 
 /******************************************************************************
  *
@@ -613,7 +630,7 @@
  *
  ******************************************************************************/
 
-struct acpi_debug_mem_block *
+static struct acpi_debug_mem_block *
 acpi_ut_find_allocation (
 	u32                             list_id,
 	void                            *allocation)
@@ -662,7 +679,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_track_allocation (
 	u32                             list_id,
 	struct acpi_debug_mem_block     *allocation,
@@ -749,7 +766,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_remove_allocation (
 	u32                             list_id,
 	struct acpi_debug_mem_block     *allocation,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utcopy.c.old	2005-01-26 22:27:24.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utcopy.c	2005-01-26 22:28:47.000000000 +0100
@@ -194,7 +194,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_copy_ielement_to_eelement (
 	u8                              object_type,
 	union acpi_operand_object       *source_object,
@@ -398,7 +398,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_copy_esimple_to_isimple (
 	union acpi_object               *external_object,
 	union acpi_operand_object       **ret_internal_object)
@@ -614,7 +614,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_copy_simple_object (
 	union acpi_operand_object       *source_desc,
 	union acpi_operand_object       *dest_desc)
@@ -713,7 +713,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_copy_ielement_to_ielement (
 	u8                              object_type,
 	union acpi_operand_object       *source_object,
@@ -826,7 +826,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_copy_ipackage_to_ipackage (
 	union acpi_operand_object       *source_obj,
 	union acpi_operand_object       *dest_obj,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utdelete.c.old	2005-01-26 22:29:27.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utdelete.c	2005-01-26 22:29:36.000000000 +0100
@@ -64,7 +64,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ut_delete_internal_obj (
 	union acpi_operand_object       *object)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utinit.c.old	2005-01-26 22:30:40.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utinit.c	2005-01-26 22:30:46.000000000 +0100
@@ -170,7 +170,7 @@
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ut_terminate (void)
 {
 	struct acpi_gpe_block_info      *gpe_block;
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c.old	2005-01-26 22:31:11.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c	2005-01-26 22:40:40.000000000 +0100
@@ -49,6 +49,19 @@
 #define _COMPONENT          ACPI_UTILITIES
 	 ACPI_MODULE_NAME    ("utmisc")
 
+static acpi_status
+acpi_ut_create_mutex (
+	acpi_mutex_handle               mutex_id);
+
+static union acpi_generic_state *
+acpi_ut_create_pkg_state (
+	void                            *internal_object,
+	void                            *external_object,
+	u16                             index);
+
+static acpi_status
+acpi_ut_delete_mutex (
+	acpi_mutex_handle               mutex_id);
 
 /*******************************************************************************
  *
@@ -595,7 +608,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_create_mutex (
 	acpi_mutex_handle               mutex_id)
 {
@@ -632,7 +645,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_delete_mutex (
 	acpi_mutex_handle               mutex_id)
 {
@@ -1092,7 +1105,7 @@
  *
  ******************************************************************************/
 
-union acpi_generic_state *
+static union acpi_generic_state *
 acpi_ut_create_pkg_state (
 	void                            *internal_object,
 	void                            *external_object,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utobject.c.old	2005-01-26 22:33:58.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utobject.c	2005-01-26 22:34:44.000000000 +0100
@@ -410,7 +410,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_get_simple_object_size (
 	union acpi_operand_object       *internal_object,
 	acpi_size                       *obj_length)
@@ -528,7 +528,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_get_element_length (
 	u8                              object_type,
 	union acpi_operand_object       *source_object,
@@ -593,7 +593,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+static acpi_status
 acpi_ut_get_package_object_size (
 	union acpi_operand_object       *internal_object,
 	acpi_size                       *obj_length)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/video.c.old	2005-01-26 22:34:56.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/video.c	2005-01-26 22:35:07.000000000 +0100
@@ -683,7 +683,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_video_dir;
+static struct proc_dir_entry	*acpi_video_dir;
 
 /* video devices */
 

